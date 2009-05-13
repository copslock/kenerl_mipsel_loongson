Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 May 2009 03:01:26 +0100 (BST)
Received: from mail-gx0-f157.google.com ([209.85.217.157]:54240 "EHLO
	mail-gx0-f157.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20026366AbZEMCBT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 13 May 2009 03:01:19 +0100
Received: by gxk1 with SMTP id 1so681122gxk.0
        for <multiple recipients>; Tue, 12 May 2009 19:01:12 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=lW0aIuz20gAasixNXPKNB1c0gEopw0rqGfH0F6ZrXOg=;
        b=PZkjyMuRWdoNPm2MKFDtoru4EN3SF7TkBAVPB881xA+PaMghe6EgqbuyXeC8sbPt8c
         Wr7M7aYG9cC78iAngm+E2AZ7nMXNsorlUQy67fXKls9uzpyYSUb/B51XkiX3YsqKpAjO
         t8eq7p5iOKXNgkVYFDijId4QhZ+xCdxf4VtB0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=j3P0gqN2nDIqVNFacqRBELShTJ9t2HI7m4+yQgqneeKEK6+m01kt2rVCYB0sHdtoni
         /JwO5xTqBukGC4MUBUQx01lRZLgInparPqsAwJNhzAaXyC3Jn12Ol+tmPzQKfLvicFlO
         W2OUN9WPyGi+6mDCbluJN9wdOeFh0giYMhRRQ=
MIME-Version: 1.0
Received: by 10.90.86.10 with SMTP id j10mr310441agb.12.1242180072303; Tue, 12 
	May 2009 19:01:12 -0700 (PDT)
In-Reply-To: <4A0A1E6B.6050908@caviumnetworks.com>
References: <1242168316-4009-1-git-send-email-ddaney@caviumnetworks.com>
	 <20090513002337.GA12536@cuplxvomd02.corp.sa.net>
	 <4A0A1E6B.6050908@caviumnetworks.com>
Date:	Tue, 12 May 2009 22:01:12 -0400
X-Google-Sender-Auth: e2ac67c04c60dc51
Message-ID: <7d1d9c250905121901n66519ed3m40f69bf5a1f36ae3@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Don't branch to eret in TLB refill.
From:	Paul Gortmaker <paul.gortmaker@windriver.com>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	David VomLehn <dvomlehn@cisco.com>, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <paul.gortmaker@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22699
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.gortmaker@windriver.com
Precedence: bulk
X-list: linux-mips

On Tue, May 12, 2009 at 9:12 PM, David Daney <ddaney@caviumnetworks.com> wrote:
> David VomLehn wrote:
>>
>> On Tue, May 12, 2009 at 03:45:16PM -0700, David Daney wrote:
>>>
>>> If the TLB refill handler is too bit and needs to be split, there is

minor nit - s/bit/big/

>>> no need to branch around the split if the branch target would be an
>>> eret.  Since the eret returns from the handler, control flow never
>>> passes it.  A branch to an eret is equivalent to the eret itself.
>>>
>>> Signed-off-by: David Daney <ddaney@caviumnetworks.com>

...

>>> +               u32 *split;
>>> +               if (split_on_eret) {
>>> +                       split = tlb_handler + 32;
>>> +               } else {
>>> +                       split = tlb_handler + 30;
>>
>> It would be a shame to pass up an opportunity to eliminate some of the
>> pile of magic constants we have in the MIPS tree. Given that the MIPS
>> documentation describes the size of the TLB Refill handler as 0x80 bytes,
>> we could add something like:
>>
>
> That would be a different patch according to the one patch per problem rule.

I don't see that as a showstopper; just replace the 30 with DVL's
definition in one separate patch that does nothing more, and then do
the conditional "-2" part in a separate patch.  Sure, it may seem like
extra cycles for nothing at this point in time, but it pays off in the
long run for folks doing a bisect on changes etc. and it improves the
readability of changesets (by having cleanups separated from technical
changes).  If you can spare the cycles, I know I would at least
appreciate the effort (and so would anyone else who ends up doing a
back or forward port.)

>
>> /* Maximum # of instructions in exception vector for TLB Refill handler */
>> #define MIPS64_TLB_REFILL_OPS   (0x80 / sizeof(union mips_instruction))
>>
>> and could change the last few lines of the code above to, for example:
>>
>>                if (split_on_eret) {
>>                        split = tlb_handler + MIPS64_TLB_REFILL_OPS;
>>                } else {
>>                        split = tlb_handler + MIPS64_TLB_REFILL_OPS - 2;
>>
>> (you'd need to include asm/inst.h to get union mips_instruction defined)
>
> It is certainly possible to do something like that, but it isn't clear to me
> that it makes it any easier to understand.

Well, for someone like me who doesn't know the low-level arch details,
I'd agree with DVL that it is easier to google "mips tlb refill" than
it is to google "32".  So it is probably a worthwhile change IMHO.

Paul.
