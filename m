Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Jun 2007 10:00:04 +0100 (BST)
Received: from qb-out-0506.google.com ([72.14.204.226]:42881 "EHLO
	qb-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20022309AbXFOJAB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 15 Jun 2007 10:00:01 +0100
Received: by qb-out-0506.google.com with SMTP id q17so492940qba
        for <linux-mips@linux-mips.org>; Fri, 15 Jun 2007 01:59:00 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=s7yKOoeJWs0RITYdtPXzJvDq+7NY73mscL8TwrVBxjsb8BmMq/JObHjz8k2zKyTmb0uWE5t9lYIbi4GvRNsJvy7RTSuogu/Y7CEHZ8hWtU/zPXLESG/gWDGF/jPEQrNDsNie6e3Gz+l/svDpswZ/LrdalQoQB8GXRoH+471O1wc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pWpO86ICyjYlpQJ8KdRK5FlrQ4TLYVCzjWI4jneePJnG6HCEKK5+7xE498PUtPLJMFQoIILoXOp8Y4tP51WJWGq1LRkNp4woPmwFjckdsLx7pFvcHBMpnxvwOHrCITzrV76aLDhx8dHFh4JIIEQp19bSril5jBBGjAcR7mbmIqs=
Received: by 10.65.147.1 with SMTP id z1mr4792781qbn.1181897940562;
        Fri, 15 Jun 2007 01:59:00 -0700 (PDT)
Received: by 10.65.204.8 with HTTP; Fri, 15 Jun 2007 01:59:00 -0700 (PDT)
Message-ID: <cda58cb80706150159j5c3d5b7p4293dc529d5ee97c@mail.gmail.com>
Date:	Fri, 15 Jun 2007 10:59:00 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH 3/5] Deforest the function pointer jungle in the time code.
Cc:	"Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
	linux-mips@linux-mips.org, "Ralf Baechle" <ralf@linux-mips.org>
In-Reply-To: <Pine.LNX.4.64N.0706141648540.25868@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11818164011355-git-send-email-fbuihuu@gmail.com>
	 <11818164023940-git-send-email-fbuihuu@gmail.com>
	 <20070614111748.GA8223@alpha.franken.de>
	 <cda58cb80706140643g63c3bf34sbd5b843a15653c3d@mail.gmail.com>
	 <Pine.LNX.4.64N.0706141501080.25868@blysk.ds.pg.gda.pl>
	 <cda58cb80706140731j1b6e8e36l96d4423db1ffd9e7@mail.gmail.com>
	 <Pine.LNX.4.64N.0706141648540.25868@blysk.ds.pg.gda.pl>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15416
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

Maciej W. Rozycki wrote:
>
>  Well, many platforms have some sort of external timer interrupt sources
> (like an 8254 or an DS1287 or even a more sophisticated timer; sometimes
> integrated in the south bridge and collecting dust there), but people tend
> to follow the path of least resistance and use the CP0 timer, even though
> it is is a valuable resource that may be used for some other purposes.  I

Which other purposes ? CP0 hpt gives generally the highest precision for
a given platform, and it seems to be your case too. I don't see which other
better purpose it can deserve other than hrtimer, tick interrupt...

> think the issue has been raised here many times already.  The CP0 timer
> has its problems too as it is one-shot only and needs complicated recovery
> if an interrupt is missed -- see c0_timer_ack().

Well I would say that because it's one-shot, it's a good timer to choose.
I don't see how you can have hrtimer support if you choose a periodic
timer...

And missed interrupts doens't seem a big deal, and the new kernel time
subsystem handle them for us already.

>
>  Please note that this generic calibration code may be used for
> calibrating the CP0 timer too -- all that you need is defining

Actually the current patchset breaks it since it changes the calibration
code to be used only for the cp0 hpt calibration. I'll change that.

> mips_timer_state appropriately, i.e. to flip at the HZ rate (it may be
> based on one of the south bridge choices mentioned above or some
> free-running counter for example), but people seem to prefer to write
> their own code for some reason. ;-)

Do you have any examples in mind which rewrite their own calibration
code ? I'm too lazy to search into all board code.

>
>>> 1. No HPT at all.
>>>
>>> 2. HPT in the chipset.
>>>
>>> 3. HPT in CP0.
>>>
>>> depending on the configuration as determined at the run time, with no
>>> predefined frequency in the cases #2 and #3.
>>>
>> Good to know.
>
>  And FYI for DEC CP0 is meant to be the last resort (current code does not

Again IMHO it should be the first choice if possible.

-- 
               Franck
