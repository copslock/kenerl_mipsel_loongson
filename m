Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Sep 2010 02:11:45 +0200 (CEST)
Received: from mail-qy0-f177.google.com ([209.85.216.177]:55525 "EHLO
        mail-qy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491166Ab0I2ALm convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 29 Sep 2010 02:11:42 +0200
Received: by qyk34 with SMTP id 34so367253qyk.15
        for <linux-mips@linux-mips.org>; Tue, 28 Sep 2010 17:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wDTsIIMvUF7l2oj6FhE3g1/1+W1vqRV0HwShph8+6LM=;
        b=NUdywmWCb5dWE/+jekCvPcGinxbWhs44bTzzHLtILXGMpGIybpAa1qJo90JaECsgd/
         MUZCpLI/hd+B09oQ1drNz7YJ1A0OXhtk7G5TZiyMrHWcXVG0jwCMMudNMwNkB57Z12NH
         gJJnBOgcJlOB+vwlmi0hAvfpkIEYVcA0uKYTM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lMY7aV06/pnVbb20hwI4mZFQG67JmHGYB/zY8efytTftacdFbBVLe7aDPAcLREapEp
         4rMvVxO6MZQ6gL6Cf8knQdiFYJPg2qNm9NORfLNrRdC/Gi+d5OhO+yr37aCVLZoU24Ty
         FB5+h7PoiIx/XDhaZmLPek2i2sjbtAax3hiq4=
MIME-Version: 1.0
Received: by 10.224.54.85 with SMTP id p21mr527526qag.267.1285719092464; Tue,
 28 Sep 2010 17:11:32 -0700 (PDT)
Received: by 10.229.221.146 with HTTP; Tue, 28 Sep 2010 17:11:32 -0700 (PDT)
In-Reply-To: <4CA21E5D.7080905@caviumnetworks.com>
References: <AANLkTi==9kzfqq=Ubdo9Ms_9N=N+7rmcvg01500C4nuc@mail.gmail.com>
        <4CA21E5D.7080905@caviumnetworks.com>
Date:   Wed, 29 Sep 2010 08:11:32 +0800
Message-ID: <AANLkTik6Uv_=G4NR41oiwTai=+pRvLy+t1U9rU3ZD=3c@mail.gmail.com>
Subject: Re: Why mips eret failed?
From:   "wilbur.chan" <wilbur512@gmail.com>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        chelly wilbur <wilbur512@gmail.com>
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 8BIT
X-archive-position: 27884
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilbur512@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 22899

2010/9/29 David Daney <ddaney@caviumnetworks.com>:
> On 09/28/2010 09:00 AM, wilbur.chan wrote:

>
> Probably not a good choice.
>
>
>> because it is just a demo,
>
> If you want your demo to work, you cannot clobber all the registers in an
> exception handler.  Most ABIs allow you to clobber only k0 and k1.
>
> In general any exception handler must save and restore all registers it
> modifies except for k0 and k1.  That is the function of SAVE_ALL and
> RESTORE_ALL.


OK, I 've added SAVL_ALL and RESTORE_ALL in handle_int,it works.


 LEAF(handle_int)
        print 'A'                 /* add for debug purpose*/
        SAVE_ALL
        nop
        CLI
        la     t9,do_IRQ
        nop
        jalr   t9
        nop
       RESTORE_ALL
       nop
  END(handle_int)


However, a new problem arised :


if I modify the main_loop like this:


   void main_loop()
 {
    local_irq_enable(); /* enable timer interrupt*/
    while(1)
    {
        loop_test1();

   }
 }
void loop_test1()
{
   loop_test2();
}

void loop_test2()
{

}

That is to say, if main_loop invoke a function that do noting but to
invoke another nop function, the timer interrupt seems

not to work properly£¬  at fisrt few seconds,  'do_irq_enter' print
every 4 seconds, but after a while ,system print 'A'  from time to

time , but not  print 'do_irq_enter'  any more.   it seemed that ,
system has not acked the  timer interrupt.


If I remove the loop_test1 in main_loop, everything works well.




I don't know why this happened. Any suggestion£¿  Thank you
