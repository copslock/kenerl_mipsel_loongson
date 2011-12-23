Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Dec 2011 12:42:51 +0100 (CET)
Received: from mail-we0-f177.google.com ([74.125.82.177]:46283 "EHLO
        mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903609Ab1LWLmn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Dec 2011 12:42:43 +0100
Received: by wera10 with SMTP id a10so5190361wer.36
        for <multiple recipients>; Fri, 23 Dec 2011 03:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4ebwNC43TGzaymbTqLzk5uhjJHk+5oAff1jcTfe+JRc=;
        b=phr83DMk1qYm1QFzEcQEJcz0jk8cL2tS/bVROPS1vz6i/fRz/V7sReuUQ/8d8MMgSN
         gMnM/HRnZuGNQrWlKm0k+tM0DebAMuPuFn6eORt1hgZ1MRO58x8tLJwoJ8CMKk920DWP
         Vbqwb+1BRCDzs37XRUNZl5Y9qAaP7rWBe2BaY=
MIME-Version: 1.0
Received: by 10.216.132.231 with SMTP id o81mr13678431wei.3.1324640558301;
 Fri, 23 Dec 2011 03:42:38 -0800 (PST)
Received: by 10.180.107.232 with HTTP; Fri, 23 Dec 2011 03:42:38 -0800 (PST)
In-Reply-To: <1324639362-18220-1-git-send-email-consul.kautuk@gmail.com>
References: <1324639362-18220-1-git-send-email-consul.kautuk@gmail.com>
Date:   Fri, 23 Dec 2011 17:12:38 +0530
Message-ID: <CAFPAmTSi0i4q+mZ3KwVpEXiSoZ0=BeWUQgeSghd0PWPN+NojfA@mail.gmail.com>
Subject: Re: [PATCH 1/1] mips: fault.c: Port OOM changes to do_page_fault
From:   Kautuk Consul <consul.kautuk@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>, Ingo Molnar <mingo@elte.hu>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        "Mohd. Faris" <mohdfarisq2010@gmail.com>,
        Kautuk Consul <consul.kautuk@gmail.com>
Content-Type: multipart/mixed; boundary=0016e6d778d7eec45f04b4c0e9cb
X-archive-position: 32157
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: consul.kautuk@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 18771

--0016e6d778d7eec45f04b4c0e9cb
Content-Type: text/plain; charset=ISO-8859-1

>
> Without these changes, my MIPS board encounters many hang and livelock
> scenarios.
> After applying this patch, OOM feature performance improves according to
> my testing.
>

Just to clarify the hang scenario I am talking about, the test case I
used to reproduce
this problem is attached to this email.
Running this a few times hangs my console and then even Ctrl-C signals
do not get handled
and I also do not get back the command prompt.

After applying this patch things seem to improve, but there are still
some hangs which I
encounter which I am further trying to debug.

However, since the generic part of the kernel(mm/filemap.c) now
supports killable and
retryable page fault handling, I thought that this change would be
valid for MIPS too.

--0016e6d778d7eec45f04b4c0e9cb
Content-Type: text/x-csrc; charset=US-ASCII; name="stress_32k.c"
Content-Disposition: attachment; filename="stress_32k.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gwj4w7ls0

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRsaWIuaD4KI2luY2x1ZGUgPHN0cmluZy5o
PgojaW5jbHVkZSA8cHRocmVhZC5oPgojaW5jbHVkZSA8dW5pc3RkLmg+CgojZGVmaW5lIEFMTE9D
X0JZVEUgNTEyKjEwMjQKI2RlZmluZSBDT1VOVCA1MAoKdm9pZCAqYWxsb2NfZnVuY3Rpb25fb25l
KCB2b2lkICpwdHIgKTsKdm9pZCAqYWxsb2NfZnVuY3Rpb25fdHdvKCB2b2lkICpwdHIgKTsKdm9p
ZCAqYWxsb2NfZnVuY3Rpb25fdGhyZWUoIHZvaWQgKnB0ciApOwp2b2lkICphbGxvY19mdW5jdGlv
bl9mb3VyKCB2b2lkICpwdHIgKTsKdm9pZCAqYWxsb2NfZnVuY3Rpb25fZml2ZSggdm9pZCAqcHRy
ICk7CnZvaWQgKmVuYWJsZV9mdW5jdGlvbiggdm9pZCAqcHRyICk7CgoKaW50IG1haW4oaW50IGFy
Z2MsIGNoYXIgKmFyZ3ZbXSkKewoJcHRocmVhZF90IHRocmVhZDEsIHRocmVhZDIsIHRocmVhZDMs
IHRocmVhZDQsIHRocmVhZDU7CgljaGFyICptZXNzYWdlMSA9ICJUaHJlYWQgMSI7CgljaGFyICpt
ZXNzYWdlMiA9ICJUaHJlYWQgMiI7CgljaGFyICptZXNzYWdlMyA9ICJUaHJlYWQgMyI7CgljaGFy
ICptZXNzYWdlNCA9ICJUaHJlYWQgNCI7CgljaGFyICptZXNzYWdlNSA9ICJUaHJlYWQgNSI7Cglp
bnQgaXJldDEgPSAtMTsKCWludCBpcmV0MiA9IC0xOwoJaW50IGlyZXQzID0gLTE7CglpbnQgaXJl
dDQgPSAtMTsKCWludCBpcmV0NSA9IC0xOwoJZm9yaygpOwoJaXJldDEgPSBwdGhyZWFkX2NyZWF0
ZSggJnRocmVhZDEsIE5VTEwsIGFsbG9jX2Z1bmN0aW9uX29uZSwgKHZvaWQqKSBtZXNzYWdlMSk7
CglpcmV0MiA9IHB0aHJlYWRfY3JlYXRlKCAmdGhyZWFkMiwgTlVMTCwgYWxsb2NfZnVuY3Rpb25f
dHdvLCAodm9pZCopIG1lc3NhZ2UyKTsKCWlyZXQyID0gcHRocmVhZF9jcmVhdGUoICZ0aHJlYWQz
LCBOVUxMLCBhbGxvY19mdW5jdGlvbl90aHJlZSwgKHZvaWQqKSBtZXNzYWdlMik7CglpcmV0MiA9
IHB0aHJlYWRfY3JlYXRlKCAmdGhyZWFkNCwgTlVMTCwgYWxsb2NfZnVuY3Rpb25fZm91ciwgKHZv
aWQqKSBtZXNzYWdlMik7CglpcmV0MiA9IHB0aHJlYWRfY3JlYXRlKCAmdGhyZWFkNSwgTlVMTCwg
YWxsb2NfZnVuY3Rpb25fZml2ZSwgKHZvaWQqKSBtZXNzYWdlMik7CgoJcHRocmVhZF9qb2luKCB0
aHJlYWQxLCBOVUxMKTsKCXB0aHJlYWRfam9pbiggdGhyZWFkMiwgTlVMTCk7CglwdGhyZWFkX2pv
aW4oIHRocmVhZDMsIE5VTEwpOwoJcHRocmVhZF9qb2luKCB0aHJlYWQ0LCBOVUxMKTsKCXB0aHJl
YWRfam9pbiggdGhyZWFkNSwgTlVMTCk7CgoJcHJpbnRmKCJUaHJlYWQgMSByZXR1cm5zOiAlZFxu
IixpcmV0MSk7CglwcmludGYoIlRocmVhZCAyIHJldHVybnM6ICVkXG4iLGlyZXQyKTsKCXByaW50
ZigiVGhyZWFkIDMgcmV0dXJuczogJWRcbiIsaXJldDMpOwoJcHJpbnRmKCJUaHJlYWQgNCByZXR1
cm5zOiAlZFxuIixpcmV0NCk7CglwcmludGYoIlRocmVhZCA1IHJldHVybnM6ICVkXG4iLGlyZXQ1
KTsKCWV4aXQoMCk7Cn0KCnZvaWQgKmFsbG9jX2Z1bmN0aW9uX3R3byggdm9pZCAqcHRyICkKewoJ
Y2hhciAqbWVzc2FnZTsKCW1lc3NhZ2UgPSAoY2hhciAqKSBwdHI7Cgl2b2lkICpteWJsb2NrW0NP
VU5UXTsKCWludCBpPSAwLGo9MDsKCWludCBmcmVlZD0wOwoJcHJpbnRmKCJtZXNzYWdlX2FsbG9j
ICBcbiIpOwoJd2hpbGUoMSkKCXsKCQltZW1zZXQobXlibG9jaywwLHNpemVvZihteWJsb2NrKSk7
CgkJcHJpbnRmKCJtZXNzYWdlX2FsbG9jICVzIFxuIixtZXNzYWdlKTsKCQlmb3IoaT0wO2k8IENP
VU5UIDtpKyspCgkJewoJCQlteWJsb2NrW2ldID0gKHZvaWQgKikgbWFsbG9jKEFMTE9DX0JZVEUp
OwoJCQltZW1zZXQobXlibG9ja1tpXSwxLCBBTExPQ19CWVRFKTsKCQl9Cgl9Cn0KCgp2b2lkICph
bGxvY19mdW5jdGlvbl9vbmUoIHZvaWQgKnB0ciApCnsKCWNoYXIgKm1lc3NhZ2U7CgltZXNzYWdl
ID0gKGNoYXIgKikgcHRyOwoJdm9pZCAqbXlibG9ja1tDT1VOVF07CglpbnQgaT0gMCxqPTA7Cglp
bnQgZnJlZWQ9MDsKCXByaW50ZigibWVzc2FnZV9hbGxvYyAgXG4iKTsKCXdoaWxlKDEpCgl7CgkJ
bWVtc2V0KG15YmxvY2ssMCxzaXplb2YobXlibG9jaykpOwoJCXByaW50ZigibWVzc2FnZV9hbGxv
YyAlcyBcbiIsbWVzc2FnZSk7CgkJZm9yKGk9MDtpPCBDT1VOVCA7aSsrKQoJCXsKCQkJbXlibG9j
a1tpXSA9ICh2b2lkICopIG1hbGxvYyhBTExPQ19CWVRFKTsKCQkJbWVtc2V0KG15YmxvY2tbaV0s
MSwgQUxMT0NfQllURSk7CgkJfQoJfQp9Cgp2b2lkICphbGxvY19mdW5jdGlvbl90aHJlZSggdm9p
ZCAqcHRyICkKewogICAgICAgY2hhciAqbWVzc2FnZTsKICAgICAgICBtZXNzYWdlID0gKGNoYXIg
KikgcHRyOwogICAgICAgIHZvaWQgKm15YmxvY2tbQ09VTlRdOwogICAgICAgIGludCBpPSAwLGo9
MDsKICAgICAgICBpbnQgZnJlZWQ9MDsKICAgICAgICBwcmludGYoIm1lc3NhZ2VfYWxsb2MgIFxu
Iik7CiAgICAgICAgd2hpbGUoMSkKICAgICAgICB7CiAgICAgICAgICAgICAgICBtZW1zZXQobXli
bG9jaywwLHNpemVvZihteWJsb2NrKSk7CiAgICAgICAgICAgICAgICBwcmludGYoIm1lc3NhZ2Vf
YWxsb2MgJXMgXG4iLG1lc3NhZ2UpOwogICAgICAgICAgICAgICAgZm9yKGk9MDtpPCBDT1VOVCA7
aSsrKQogICAgICAgICAgICAgICAgewogICAgICAgICAgICAgICAgICAgICAgICBteWJsb2NrW2ld
ID0gKHZvaWQgKikgbWFsbG9jKEFMTE9DX0JZVEUpOwogICAgICAgICAgICAgICAgICAgICAgICBt
ZW1zZXQobXlibG9ja1tpXSwxLCBBTExPQ19CWVRFKTsKICAgICAgICAgICAgICAgIH0KICAgICAg
ICB9Cn0Kdm9pZCAqYWxsb2NfZnVuY3Rpb25fZm91ciggdm9pZCAqcHRyICkKewogICAgICAgY2hh
ciAqbWVzc2FnZTsKICAgICAgICBtZXNzYWdlID0gKGNoYXIgKikgcHRyOwogICAgICAgIHZvaWQg
Km15YmxvY2tbQ09VTlRdOwogICAgICAgIGludCBpPSAwLGo9MDsKICAgICAgICBpbnQgZnJlZWQ9
MDsKICAgICAgICBwcmludGYoIm1lc3NhZ2VfYWxsb2MgIFxuIik7CiAgICAgICAgd2hpbGUoMSkK
ICAgICAgICB7CiAgICAgICAgICAgICAgICBtZW1zZXQobXlibG9jaywwLHNpemVvZihteWJsb2Nr
KSk7CiAgICAgICAgICAgICAgICBwcmludGYoIm1lc3NhZ2VfYWxsb2MgJXMgXG4iLG1lc3NhZ2Up
OwogICAgICAgICAgICAgICAgZm9yKGk9MDtpPCBDT1VOVCA7aSsrKQogICAgICAgICAgICAgICAg
ewogICAgICAgICAgICAgICAgICAgICAgICBteWJsb2NrW2ldID0gKHZvaWQgKikgbWFsbG9jKEFM
TE9DX0JZVEUpOwogICAgICAgICAgICAgICAgICAgICAgICBtZW1zZXQobXlibG9ja1tpXSwxLCBB
TExPQ19CWVRFKTsKICAgICAgICAgICAgICAgIH0KICAgICAgICB9Cn0Kdm9pZCAqYWxsb2NfZnVu
Y3Rpb25fZml2ZSggdm9pZCAqcHRyICkKewogICAgICAgY2hhciAqbWVzc2FnZTsKICAgICAgICBt
ZXNzYWdlID0gKGNoYXIgKikgcHRyOwogICAgICAgIHZvaWQgKm15YmxvY2tbQ09VTlRdOwogICAg
ICAgIGludCBpPSAwLGo9MDsKICAgICAgICBpbnQgZnJlZWQ9MDsKICAgICAgICBwcmludGYoIm1l
c3NhZ2VfYWxsb2MgIFxuIik7CiAgICAgICAgd2hpbGUoMSkKICAgICAgICB7CiAgICAgICAgICAg
ICAgICBtZW1zZXQobXlibG9jaywwLHNpemVvZihteWJsb2NrKSk7CiAgICAgICAgICAgICAgICBw
cmludGYoIm1lc3NhZ2VfYWxsb2MgJXMgXG4iLG1lc3NhZ2UpOwogICAgICAgICAgICAgICAgZm9y
KGk9MDtpPCBDT1VOVCA7aSsrKQogICAgICAgICAgICAgICAgewogICAgICAgICAgICAgICAgICAg
ICAgICBteWJsb2NrW2ldID0gKHZvaWQgKikgbWFsbG9jKEFMTE9DX0JZVEUpOwogICAgICAgICAg
ICAgICAgICAgICAgICBtZW1zZXQobXlibG9ja1tpXSwxLCBBTExPQ19CWVRFKTsKICAgICAgICAg
ICAgICAgIH0KICAgICAgICB9Cn0K
--0016e6d778d7eec45f04b4c0e9cb--
