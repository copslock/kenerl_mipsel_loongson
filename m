Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Oct 2011 10:01:51 +0100 (CET)
Received: from mail.lemote.com ([222.92.8.141]:38512 "EHLO lemote.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903553Ab1JaJBm (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 31 Oct 2011 10:01:42 +0100
Received: from localhost (localhost [127.0.0.1])
        by lemote.com (Postfix) with ESMTP id 1C75C3410E
        for <linux-mips@linux-mips.org>; Mon, 31 Oct 2011 16:36:17 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at lemote.com
Received: from lemote.com ([127.0.0.1])
        by localhost (www.lemote.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id m7Ttj3gpg3cv for <linux-mips@linux-mips.org>;
        Mon, 31 Oct 2011 16:36:08 +0800 (CST)
Received: from mail-fx0-f49.google.com (mail-fx0-f49.google.com [209.85.161.49])
        by lemote.com (Postfix) with ESMTP id 9D5CE340C9
        for <linux-mips@linux-mips.org>; Mon, 31 Oct 2011 16:36:07 +0800 (CST)
Received: by faaf16 with SMTP id f16so7179004faa.36
        for <linux-mips@linux-mips.org>; Mon, 31 Oct 2011 02:01:21 -0700 (PDT)
Received: by 10.223.15.10 with SMTP id i10mr27808933faa.17.1320051681001; Mon,
 31 Oct 2011 02:01:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.101.140 with HTTP; Mon, 31 Oct 2011 02:00:58 -0700 (PDT)
From:   Chen Jie <chenj@lemote.com>
Date:   Mon, 31 Oct 2011 17:00:58 +0800
Message-ID: <CAGXxSxXmgzxN361Cko1fY_+oWwfgjXLhS61gtvqB8YYXHXZVyw@mail.gmail.com>
Subject: [MIPS]clocks_calc_mult_shift() may gen a too big mult value
To:     linux-mips@linux-mips.org, LKML <linux-kernel@vger.kernel.org>
Cc:     johnstul@us.ibm.com, tglx@linutronix.de, yanhua <yanh@lemote.com>,
        =?UTF-8?B?6aG55a6H?= <xiangy@lemote.com>,
        zhangfx <zhangfx@lemote.com>,
        =?UTF-8?B?5a2Z5rW35YuH?= <sunhy@lemote.com>
Content-Type: multipart/mixed; boundary=0015174482148802f204b0947b28
X-archive-position: 31327
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenj@lemote.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 21824

--0015174482148802f204b0947b28
Content-Type: text/plain; charset=ISO-8859-1

Hi all,

On MIPS, with maxsec=4, clocks_calc_mult_shift() may generate a very
big mult, which may easily cause timekeeper.mult overflow within
timekeeping jobs.

e.g. when clock freq was 250000500(i.e. mips_hpt_frequency=250000500,
and the CPU Freq will be 250000500*2=500001000), mult will be
0xffffde72

Attachment is a script that calculates mult values for CPU Freq
between 400050000 and 500050000, with 1KHz step. It outputs mult
values greater than 0xf0000000:
CPU Freq:500001000, mult:0xffffde72, shift:30
CPU Freq:500002000, mult:0xffffbce4, shift:30
CPU Freq:500003000, mult:0xffff9b56, shift:30
CPU Freq:500004000, mult:0xffff79c9, shift:30
...

The peak value appears around CPU_freq=500001000.

To avoid this, it may need:
1. Supply a bigger maxsec value?
2. In clocks_calc_mult_shift(), pick next mult/shift pair if mult is
too big? Then maxsec will not be strictly obeyed.
3. Change timekeeper.mult to u64?
4. ...

Any idea?



--
Regards,
- Chen Jie

--0015174482148802f204b0947b28
Content-Type: text/x-python; charset=US-ASCII; name="mult-test.py"
Content-Disposition: attachment; filename="mult-test.py"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_guf66e8v0

IyEvYmluL2VudiBweXRob24KCmRlZiBjbG9ja3NfY2FsY19tdWx0X3NoaWZ0KGZyb21fLCB0b18s
IG1heHNlYyk6CglzZnRhY2MgPSAzMjsKCgl0bXAgPSBtYXhzZWMgKiBmcm9tXyA+PiAzMjsKCXdo
aWxlIHRtcDoKCQl0bXAgPj49IDEKCQlzZnRhY2MgLT0gMQoKCWZvciBzZnQgaW4geHJhbmdlKDMy
LCAwLCAtMSk6CgkJdG1wID0gdG9fIDw8IHNmdDsKCQl0bXAgKz0gKGZyb21fIC8gMikKCQl0bXAg
Lz0gZnJvbV8KCQlpZiAoKHRtcCA+PiBzZnRhY2MpID09IDApOgoJCQlicmVhawoKCW11bHQgPSB0
bXAKCXNoaWZ0ID0gc2Z0CglyZXR1cm4gbXVsdCwgc2hpZnQgCgpmb3IgaSBpbiB4cmFuZ2UoNDAw
MDUwMDAwLCA1MDAwNTAwMDAsIDEwMDApOgoJbXVsdCwgc2hpZnQgPSBjbG9ja3NfY2FsY19tdWx0
X3NoaWZ0KGkvMiwgMTAwMDAwMDAwMCwgNCkKCWlmIG11bHQgPiAweGYwMDAwMDAwOgoJCXByaW50
ICJDUFUgRnJlcTolZCwgbXVsdDoweCV4LCBzaGlmdDolZCIgJSAoaSwgbXVsdCwgc2hpZnQpCg==
--0015174482148802f204b0947b28--
