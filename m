Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Apr 2014 05:40:30 +0200 (CEST)
Received: from mail-pd0-f178.google.com ([209.85.192.178]:54566 "EHLO
        mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817913AbaDUDk2Cbc4b (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Apr 2014 05:40:28 +0200
Received: by mail-pd0-f178.google.com with SMTP id x10so3239999pdj.37
        for <linux-mips@linux-mips.org>; Sun, 20 Apr 2014 20:40:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=mRwZI0YGMjpp/heACU05MAYMvms735XukCPTy7Ls0l0=;
        b=O1d9wybmXu74GrKOeQSL2ybEnBqmCFf9+d/abubUd7LddesbxPXp8GtFegQPobxfbT
         FKRHDvcoXk0OTa4z0T7jBKhgdw53Bm6K+jJDRZVwOo20zY2m6TQojCVz+FvB8sA1XPuf
         XtuB3XklRAEMq9Sl+F47rk42m0e+tp1KkKEYPTRuyBUJxRpMp0lSoQpsdmaIGvD3oVaq
         dKLA/n/tcLJ1bcGEINJi4VZmxE/KCNz7D9BSYNz2qa+I3yl519zR47+eEDmJo0eewyXv
         0ECJWGhLk9RUUTgegEcMuyCchzv86TO2zRn4A0HWCIUeTK1oz6WtrKNsYynM0OlIFkWi
         49ZQ==
X-Gm-Message-State: ALoCoQlQtSfB0CAB2jrah6kk2rB7H6+3Uttd6JfAbZyqvkDw9sMCDhL7Tt9zdH/ngbh1V4eZMQ+J
X-Received: by 10.68.110.226 with SMTP id id2mr36017563pbb.40.1398051621156;
        Sun, 20 Apr 2014 20:40:21 -0700 (PDT)
Received: from localhost ([111.93.218.67])
        by mx.google.com with ESMTPSA id yj6sm105426511pab.19.2014.04.20.20.40.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 20 Apr 2014 20:40:20 -0700 (PDT)
Date:   Mon, 21 Apr 2014 09:10:15 +0530
From:   Prem Karat <pkarat@mvista.com>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [RFC PATCH 1/1] MIPS: Enable VDSO randomization.
Message-ID: <20140421034015.GA2489@064904.mvista.com>
References: <20140419093302.GH2717@064904.mvista.com>
 <5352FF15.2080003@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5352FF15.2080003@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <pkarat@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39873
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pkarat@mvista.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On 04/19/14 03:56pm, David Daney wrote:
> On 04/19/2014 02:33 AM, Prem Karat wrote:
> >Based on commit 1091458d09e1a (mmap randomization)
> >
> >For 32-bit address spaces randomize within a
> >16MB space, for 64-bit within a 256MB space.
> >
> 
> How was it tested (i.e. what workload did you run to verify that the
> kernel still functions with this change)?
>
David, Sergei,

Thank You for reviewing the patch. 

Am using test suite from Ubuntu which is available here.
http://bazaar.launchpad.net/~ubuntu-bugcontrol/qa-regression-testing/master/files/head:/scripts/kernel-security/aslr/

Please find the test results below.

Without Patch (VDSO is not randomized)
---------------------------------------

root@Maleo:~# ./aslr vdso
FAIL: ASLR not functional (vdso always at 0x7fff7000)

root@Maleo:~# ./aslr rekey vdso
pre_val==cur_val
value=0x7fff7000

With patch:(VDSO is randmoized and doesn't interfere with stack)
----------------------------------------------------------------
root@cavium-octeon2:~# ./aslr rekey vdso
pre_val!=cur_val
previous_value=0x7f830ea2
current_value=0x776e2000

root@cavium-octeon2:~# ./aslr rekey vdso
pre_val!=cur_val
previous_value=0x7fb0cea2
current_value=0x77209000

root@cavium-octeon2:~# ./aslr rekey vdso
pre_val!=cur_val
previous_value=0x7f985ea2
current_value=0x7770c000

root@cavium-octeon2:~# ./aslr rekey vdso
pre_val!=cur_val
previous_value=0x7fbc6ea2
current_value=0x7fe25000

root@cavium-octeon2:~# ./aslr vdso
ok: ASLR of vdso functional
root@cavium-octeon2:~#

 
> >+
> >+	return (STACK_TOP + offset);
> 
> How can you be sure this address doesn't collide with, or otherwise
> interfere with, the stack?
>

It doesn't, as this program can print the maps file and here is the output of the
maps file each time we run aslr showing maps file.

root@cavium-octeon2:~# ./aslr rekey maps
78584000-785a5000 rwxp 00000000 00:00 0                                  [heap]
7f9d0000-7f9f1000 rw-p 00000000 00:00 0                                  [stack]
7ffa5000-7ffa6000 r-xp 00000000 00:00 0                                  [vdso]

root@cavium-octeon2:~# ./aslr rekey maps
77de0000-77e01000 rwxp 00000000 00:00 0                                  [heap]
7f91b000-7f93c000 rw-p 00000000 00:00 0                                  [stack]
7ff99000-7ff9a000 r-xp 00000000 00:00 0                                  [vdso]

root@cavium-octeon2:~# ./aslr rekey maps
77d7f000-77da0000 rwxp 00000000 00:00 0                                  [heap]
7fc2a000-7fc4b000 rw-p 00000000 00:00 0                                  [stack]
7fe09000-7fe0a000 r-xp 00000000 00:00 0                                  [vdso]

root@cavium-octeon2:~# ./aslr rekey maps
7794c000-7794d000 r-xp 00000000 00:00 0                                  [vdso]
77e4b000-77e6c000 rwxp 00000000 00:00 0                                  [heap]
7f6e7000-7f708000 rw-p 00000000 00:00 0                                  [stack]
root@cavium-octeon2:~#  

> 
> Also, as mentioned by Sergei, run checkpatch.pl to catch obvious
> stylistic problems before submitting patches.
> 

I will make the changes and send a v2 patch. 


-- 
	-prem
