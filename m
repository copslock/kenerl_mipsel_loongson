Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Apr 2010 03:29:38 +0200 (CEST)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:44882 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492705Ab0D1B3f (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Apr 2010 03:29:35 +0200
Received: by gyb11 with SMTP id 11so7153194gyb.36
        for <linux-mips@linux-mips.org>; Tue, 27 Apr 2010 18:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=BHcZ0m0MMKlI3wImDAJ1o8XGrfwa8NKaSq4K3Kgo3Hs=;
        b=dJ+IpibCbZTJ4a+03npewFm+gbVtKLTTYkHh8Amords43bxPfbByMSawn3GvMoE5gX
         Jpn3B9CCgjPhTdy3sNQFsqhRGMGdBx8GHqJNUC/AArWenMoVy6QUEQl1oZ6ChNvQ+jyD
         bFioqLzt87ZHLr0cWEYFXfzXa8KIlbLKQwIps=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=wSH/pOjmvVmSQTm2YMCkp82Mx2Oa6OBDyCL8WlHj+BI2oESYIgGX/D+WlLfxaKbR/j
         a3MMr2v5rgPvIkQbVuwBEs6C0CEC75lhbKpEU7LrxaYYWlFCGZ2FgMginWf5f2IrXM+i
         32luE08oRMhYG6eYTioqZrXm5eutdD8n7MerU=
MIME-Version: 1.0
Received: by 10.91.190.11 with SMTP id s11mr3634008agp.50.1272418167789; Tue, 
        27 Apr 2010 18:29:27 -0700 (PDT)
Received: by 10.90.99.14 with HTTP; Tue, 27 Apr 2010 18:29:27 -0700 (PDT)
Date:   Wed, 28 Apr 2010 09:29:27 +0800
Message-ID: <r2pe997b7421004271829rffc1e685ic649ce3b53325271@mail.gmail.com>
Subject: [octeon]segment without execution priviledge,causing system down.
From:   "wilbur.chan" <wilbur512@gmail.com>
To:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <wilbur512@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26491
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilbur512@gmail.com
Precedence: bulk
X-list: linux-mips

I'm using a modified kernel version derived from 2.6.21.7,and the cpu
is octeon cn5860. Strangely I found that , when executing

some instruction in  un-executable segment, the system will hang on,
together with console  down, and could not response to ping

command.

cn5860 has 16 CPUs,  in our system , each non-zero cpu is running a
real-time user-mode process with 99 priority(network

business) , causing non-zero cpus to 100% cpu-usage.

while cpu 0 ,is in charge of coordinating the whole system ,almost to
5~6% cpu-usage.



That is , the following code ,will cause a problem , which hang the
cpu 0, and then hang the whole system:

#include <stdio.h>
#include <stdlib.h>

char stack[8*1024] = {0}; // in un-executable segment
void (*func)(void);
int main()
{
 	func = (void (*)(void))stack;  //convert to function  pointer
 	func();    //cpu will hang
    return 0;
}

In my opinion, the code above should generate a page_fault exception ,
and caused SIGSEGV error, however in my

system , it hang on directly.


Any one knows why this happened? Thanks




regards,

wilbur
