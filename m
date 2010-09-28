Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Sep 2010 18:00:36 +0200 (CEST)
Received: from mail-qy0-f177.google.com ([209.85.216.177]:46503 "EHLO
        mail-qy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491131Ab0I1QAd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Sep 2010 18:00:33 +0200
Received: by qyk34 with SMTP id 34so10482929qyk.15
        for <linux-mips@linux-mips.org>; Tue, 28 Sep 2010 09:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type;
        bh=0LV5Mxf22Qt3mPpkzR8uOW3SfR5eVkuEw27qoViWNBo=;
        b=sN7YQCOWfdoYWYwHeKlTw6IibnZgv/i9AqJ6tP9mp9b7Vm1QMKXjuucx7mYX+AZUIb
         ESrgz/bZ91gEeayhPKUvEcn7cWsk0fDwcjlTUu1u1/JLz7ByMP9inHNv/JtSz/pQL1rE
         Z+YPYF+Jv1f6c0GmDVyuzJnu39hUFqxx61Zxg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=WMWo/vvIEluoLSAIGoUkc4ZIHU9MKdpkvbGNc5tvTSE3N0Py3bWNBTDtBFQGMK3HD3
         A14QH+GOHXhgULY8Qs8FNrpzqVEJgP2wjaAGQ8voNxZzDqlMLQxeA2I/xbpcN5U7A/kN
         XJYHnSWmFxUApueINhO9HXXFi4gvmVrbOzgY0=
MIME-Version: 1.0
Received: by 10.229.233.142 with SMTP id jy14mr118575qcb.77.1285689627424;
 Tue, 28 Sep 2010 09:00:27 -0700 (PDT)
Received: by 10.229.221.146 with HTTP; Tue, 28 Sep 2010 09:00:26 -0700 (PDT)
Date:   Wed, 29 Sep 2010 00:00:26 +0800
Message-ID: <AANLkTi==9kzfqq=Ubdo9Ms_9N=N+7rmcvg01500C4nuc@mail.gmail.com>
Subject: Why mips eret failed?
From:   "wilbur.chan" <wilbur512@gmail.com>
To:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Cc:     chelly wilbur <wilbur512@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 27876
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilbur512@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 22505

HI all!

I'm learning to write a timer interrupt handler by my own on
mips32(xls416 with 32bits cross compiled) , but to find that, eret
failed to quit.

detail:

I took the following steps:

1)  copy exception vector to the physical address 0x180, then set ebase with it.

     that is , memcpy these three  instructions to 0x80000180,with
size 0x80 bytes:

        lui    k1, HIGH(handle_int)
       addiu  k1, k1, LOW(handle_int)
       jr     k1


 2)     this is handle_int , which is  the entry of interrupts

    LEAF(handle_int)
         nop
         la     t9,do_IRQ
         nop
         jalr   t9
         nop
        eret
        nop
   END(handle_int)

 ps:

 'nop' is used to avoid delay slot,  and I did not add 'SAVE_ALL'  or
'RESTORE_ALL'  in handle_int, because it is just a demo, I want the
interrupt return

immediately.

3) this is do_IRQ

 void do_IRQ(void)
{
    ack_irq();    /* ack with compare register ,which is used to
generate timer interrupt*/
    print("do_irq enter\n");
}



4) there is a main loop like  this:


    void main_loop()
  {
     local_irq_enable(); /* enable timer interrupt*/
    while(1)
    {
         print("loop...\n");

    }
 }

I found that , the message in do_IRQ  prints  every 4s (I' ve set
timer of 4 seconds),  however, the message in main_loop did not appear


q1:  does that mean, the timer interrupt has never quit to main_loop ,
but a nested interrupt?



q2:  that is to say, eret in handle_int failed to quit to main_loop?

q3: why this happend?


Thank you !
