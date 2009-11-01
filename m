Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Nov 2009 16:18:44 +0100 (CET)
Received: from mail-gx0-f227.google.com ([209.85.217.227]:38323 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493773AbZKAPSh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 1 Nov 2009 16:18:37 +0100
Received: by gxk27 with SMTP id 27so431663gxk.7
        for <multiple recipients>; Sun, 01 Nov 2009 07:18:31 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=R0sNxzuV+TV78/1vjRkwuqdZb8K/8bv0t2rRAYWDA1Q=;
        b=K5sfSWXi28I0taRy4zKjuHu5l/G/uUKfF/NxySUFB0YzMllnIA/g06WLPOR9cF4D46
         uB/FUNyw/Sa9ZWruHzHbFBrfxETBaFng3s0B8zck9+k8CFpN26JS8JGQxshdOBcTlwpA
         l7PGemcPpyOuyVdOS1S5enMEXseeRLvv7zrVg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Jpwqu7uIYY2rgchtFoRtVBWQx/QVuLnVtEQlnjkILy6VQK5u5SJPoywVLJnkRBHw9f
         xi/ejdBo5EGxHV4kinxB/OHGtWuJ3ou+lkSqu2vvTW+ruv+vi01RmFQXHv2yI6yxGqHn
         YoZ6GCkDnsUIZkabDs95xuMJmVTp/TVX+plO8=
MIME-Version: 1.0
Received: by 10.90.62.21 with SMTP id k21mr7840940aga.10.1257088711086; Sun, 
	01 Nov 2009 07:18:31 -0800 (PST)
In-Reply-To: <20091101071407.GC4551@linux-mips.org>
References: <e997b7420910281651p24b8e367m1e2ddbc1b95ac623@mail.gmail.com>
	 <20091101071407.GC4551@linux-mips.org>
Date:	Sun, 1 Nov 2009 23:18:31 +0800
Message-ID: <e997b7420911010718x2da0eaebi9a30e448446782a0@mail.gmail.com>
Subject: Re: Problem in booting when calling calibrate_delay
From:	"wilbur.chan" <wilbur512@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <wilbur512@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24600
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wilbur512@gmail.com
Precedence: bulk
X-list: linux-mips

2009/11/1 Ralf Baechle <ralf@linux-mips.org>:
> On Thu, Oct 29, 2009 at 07:51:52AM +0800, wilbur.chan wrote:
>
>> Howerver, the code seemd to stop before calling 'start_kernel--->
>>
>> calibrate_delay ' .
>>
> When something like this happens it is in most cases caused by timer
> interrupt not working.
>
>  Ralf
>

Hi, ralf ,  I found that, jiffies remain the same when booting , so
calibrate_delay loop all the time , at while(ticks==jiffies);

I guess it was the problem of timer interrupt as you said.


Someone told me that , it might be the problem of console_init ,but I
still don't know where exactly

the problem is .

Can you tell more about how to fix this ?


Thx
