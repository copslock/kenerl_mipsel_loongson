Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Sep 2010 05:12:48 +0200 (CEST)
Received: from mail-iw0-f177.google.com ([209.85.214.177]:52963 "EHLO
        mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490960Ab0I2DMo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Sep 2010 05:12:44 +0200
Received: by iwn41 with SMTP id 41so594763iwn.36
        for <linux-mips@linux-mips.org>; Tue, 28 Sep 2010 20:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=2PywSe1BkXB7gzJ6TxMRtXQBpR4pjdjH6v2FVymKN0M=;
        b=Mrj19kOdl01Xjs/p/l8Q7Jy5qqJ4L6s12dRNoGo9EiamFU8L8mEOmPi65A4m6c099E
         PJCGwtlwRgYXKksKAMsKhtJkIZlix23Z5Fp4RBGw1jjIQ7IauHumWKtFdltGfg2QsVBc
         sgpxjat0RpWEyziOMPs02gklO/nbHhsOoZmt0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        b=c/uLLlWmlv+g1G1nTa6RqbDBNI6elHE+x7XmZy5MNdNZirZ1Joflk7R+WzmmfbdO/g
         eDK3T/344fqfhp40uQl4gd1HIl3JsMIGg8xxRU4KZffG3QQGKs7Q/SEeuraOniZFR/qp
         uP294eKnqXVUoI+IvZ6b5iok0TATAl1DGlOiw=
Received: by 10.231.33.129 with SMTP id h1mr852010ibd.140.1285729961726;
        Tue, 28 Sep 2010 20:12:41 -0700 (PDT)
Received: from rcwf64-moto (KD113150081245.ppp-bb.dion.ne.jp [113.150.81.245])
        by mx.google.com with ESMTPS id u3sm2567383ibu.6.2010.09.28.20.12.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Sep 2010 20:12:40 -0700 (PDT)
Date:   Wed, 29 Sep 2010 12:10:18 +0900
From:   Adam Jiang <jiang.adam@gmail.com>
To:     "wilbur.chan" <wilbur512@gmail.com>
Cc:     David Daney <ddaney@caviumnetworks.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: Why mips eret failed?
Message-ID: <20100929031018.GB7999@rcwf64-moto>
Mail-Followup-To: Adam Jiang <jiang.adam@gmail.com>,
        "wilbur.chan" <wilbur512@gmail.com>,
        David Daney <ddaney@caviumnetworks.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
References: <AANLkTi==9kzfqq=Ubdo9Ms_9N=N+7rmcvg01500C4nuc@mail.gmail.com>
 <4CA21E5D.7080905@caviumnetworks.com>
 <AANLkTik6Uv_=G4NR41oiwTai=+pRvLy+t1U9rU3ZD=3c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AANLkTik6Uv_=G4NR41oiwTai=+pRvLy+t1U9rU3ZD=3c@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 27885
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jiang.adam@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 22980

Quick reply on top

Take a look at 

https://www.ibm.com/developerworks/mydeveloperworks/blogs/ddou/tags/u-boot?lang=en

This may help, I suppose. Why don't forward this message to uboot
mailing list?

On Wed, Sep 29, 2010 at 08:11:32AM +0800, wilbur.chan wrote:
> 2010/9/29 David Daney <ddaney@caviumnetworks.com>:
> > On 09/28/2010 09:00 AM, wilbur.chan wrote:
> 
> >
> > Probably not a good choice.
> >
> >
> >> because it is just a demo,
> >
> > If you want your demo to work, you cannot clobber all the registers in an
> > exception handler.  Most ABIs allow you to clobber only k0 and k1.
> >
> > In general any exception handler must save and restore all registers it
> > modifies except for k0 and k1.  That is the function of SAVE_ALL and
> > RESTORE_ALL.
> 
> 
> OK, I 've added SAVL_ALL and RESTORE_ALL in handle_int,it works.
> 
> 
>  LEAF(handle_int)
>         print 'A'                 /* add for debug purpose*/
>         SAVE_ALL
>         nop
>         CLI
>         la     t9,do_IRQ
>         nop
>         jalr   t9
>         nop
>        RESTORE_ALL
>        nop
>   END(handle_int)
> 
> 
> However, a new problem arised :
> 
> 
> if I modify the main_loop like this:
> 
> 
>    void main_loop()
>  {
>     local_irq_enable(); /* enable timer interrupt*/
>     while(1)
>     {
>         loop_test1();
> 
>    }
>  }
> void loop_test1()
> {
>    loop_test2();
> }
> 
> void loop_test2()
> {
> 
> }
> 
> That is to say, if main_loop invoke a function that do noting but to
> invoke another nop function, the timer interrupt seems
> 
> not to work properly，  at fisrt few seconds,  'do_irq_enter' print
> every 4 seconds, but after a while ,system print 'A'  from time to
> 
> time , but not  print 'do_irq_enter'  any more.   it seemed that ,
> system has not acked the  timer interrupt.
> 
> 
> If I remove the loop_test1 in main_loop, everything works well.
> 
> 
> 
> 
> I don't know why this happened. Any suggestion？  Thank you
> 
