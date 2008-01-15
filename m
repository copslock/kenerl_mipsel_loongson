Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jan 2008 14:19:12 +0000 (GMT)
Received: from fg-out-1718.google.com ([72.14.220.159]:8697 "EHLO
	fg-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S20036914AbYAOOTD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 15 Jan 2008 14:19:03 +0000
Received: by fg-out-1718.google.com with SMTP id d23so2541336fga.32
        for <linux-mips@linux-mips.org>; Tue, 15 Jan 2008 06:19:02 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=eSmgJEcTYQYUdVOuLh65wW4NcYLwBsBHgTJCpKM03Pk=;
        b=N0pNnS+ajLR5ybqwsi1q2UscQ/CiTif6tBTi1sFws84qy2ugqThrICCPKlmuFAIsH6hXnUJWXHTWa/eesEfolI45nSlqWCuzU3kOQmv/qCmyKcOM/z7CnP7IB3RFpd5tme55Q1wBIMCL5fmGLiek0iCygCIHhZxMWjphT13br28=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=rBgo3iVk2NIAZGqasxuQLVek40EIJz8oSlvWk3TMbLNNVsIx8Fgo/HL1ietBfGC7HWx44q86L+SyZg8PiwKcRToWECiKOzIaI0eCE4KgXjNG0Ml2ylbmi8m/GYcnWz8HRzkGW17WTrZGdzaXzNvi3aq4cBR4fP/qgu0OCpLAqXE=
Received: by 10.86.97.7 with SMTP id u7mr7431374fgb.54.1200406742593;
        Tue, 15 Jan 2008 06:19:02 -0800 (PST)
Received: from ?192.168.1.3? ( [91.76.28.153])
        by mx.google.com with ESMTPS id 3sm7833413fge.7.2008.01.15.06.19.00
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 15 Jan 2008 06:19:01 -0800 (PST)
Message-ID: <478CC0D2.4070509@gmail.com>
Date:	Tue, 15 Jan 2008 17:18:58 +0300
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
Organization: DmVo Home
User-Agent: Thunderbird 1.5.0.14pre (X11/20071022)
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
CC:	Geert Uytterhoeven <geert@linux-m68k.org>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [SPAM] [PATCH][MIPS] Add Atlas to feature-removal-schedule.
References: <478BD0D2.2060004@gmail.com> <Pine.LNX.4.64.0801142302001.2335@anakin> <478BEDD7.6070100@gmail.com> <Pine.LNX.4.64N.0801151156460.23975@blysk.ds.pg.gda.pl> <478CB437.9080006@gmail.com> <Pine.LNX.4.64N.0801151338150.23975@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.64N.0801151338150.23975@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18057
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki пишет:
> On Tue, 15 Jan 2008, Dmitri Vorobiev wrote:
> 
>> 1) I would like to make a massive cleanup in the arch/mips/mips-boards
>>    for the reasons explained here:
>>
>> http://www.linux-mips.org/archives/linux-mips/2008-01/msg00136.html
> 
>  You are certainly welcome to do so!
> 
>> 2) Removing Atlas would reduce the clean-up effort.
> 
>  You can make it a bonus project ;-) -- I would certainly do some testing 
> with real hardware if pieces of software start flying by.

OK, thanks for your reply. I'll try to proceed with the cleanup without
removing Atlas.

Dmitri
