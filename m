Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jan 2008 13:26:11 +0000 (GMT)
Received: from fg-out-1718.google.com ([72.14.220.154]:22370 "EHLO
	fg-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S20036782AbYAON0C (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 15 Jan 2008 13:26:02 +0000
Received: by fg-out-1718.google.com with SMTP id d23so2526597fga.32
        for <linux-mips@linux-mips.org>; Tue, 15 Jan 2008 05:26:01 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=5zKXXk9uiIO1y0JaL872hHU35qrHBgzfx7tBUf7US5U=;
        b=T0BHumfsPb7ySQGagefu7mwcmTfGGB5ePjprp7URw90nmoTPkDFYpUfz+uWMVaHyvqjUY/0SxSUD732yPu9soZ1ji9NA3rcj+dDkDQXOi0Trt9jWMeugb0hMw2p6LBsp9JbPvz9mbN4AZ76OqaZ8D1WzUGfyOp5muPrJSyfQb0A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=f0D4u9by2TWOWuGDGV/V7LvguuGEM4tLlP1XW3MeG2spBQesTtWFmtoBtx4I/gyUPzkuAdnFOX8nvW+T/RtSeUQgcFvEVsfhiwYOl1NRR6jcbEdpkqeQ4RAhKpCkuiaUMRQI+qgoh+w9LfBfnY9fExKDkHRKRUSNoh+GTNFUnR8=
Received: by 10.86.77.5 with SMTP id z5mr7387889fga.41.1200403560895;
        Tue, 15 Jan 2008 05:26:00 -0800 (PST)
Received: from ?192.168.1.3? ( [91.76.28.153])
        by mx.google.com with ESMTPS id 31sm10884532fkt.14.2008.01.15.05.25.29
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 15 Jan 2008 05:25:45 -0800 (PST)
Message-ID: <478CB437.9080006@gmail.com>
Date:	Tue, 15 Jan 2008 16:25:11 +0300
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
Organization: DmVo Home
User-Agent: Thunderbird 1.5.0.14pre (X11/20071022)
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
CC:	Geert Uytterhoeven <geert@linux-m68k.org>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [SPAM] [PATCH][MIPS] Add Atlas to feature-removal-schedule.
References: <478BD0D2.2060004@gmail.com> <Pine.LNX.4.64.0801142302001.2335@anakin> <478BEDD7.6070100@gmail.com> <Pine.LNX.4.64N.0801151156460.23975@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.64N.0801151156460.23975@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18054
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki пишет:
> On Tue, 15 Jan 2008, Dmitri Vorobiev wrote:
> 
>>>> +
>>>> +What:	Support for MIPS Technologies' Altas evaluation board
>>>                                                ^^^^^
>>> 					       Atlas
>> This is what happens when doing things in a rush. Thanks, Geert.
> 
>  Hmm, I wonder why you'd be in such a rush to remove my pet project... ;-) 
> The last time I tried it worked; unfortunately I have since been taken 

This was my way of reasoning here:

1) I would like to make a massive cleanup in the arch/mips/mips-boards
   for the reasons explained here:

http://www.linux-mips.org/archives/linux-mips/2008-01/msg00136.html

2) Removing Atlas would reduce the clean-up effort.

3) According to Ralf, the user base for Atlas is zero, the board itself
   is buggy.

4) History knows of an attempt to remove Atlas:

http://www.linux-mips.org/archives/linux-mips/2007-06/msg00153.html

5) Nobody is losing, man-hours are saved. No explanation of why not to do that.
   Hence, the patch to the feature-removal-schedule.txt.

> away my second serial port that I used as a terminal device for the Atlas 
> lying next to me and the first port I have in continuous use.  I'll see if 
> I can give it a hit before March though -- any issues with the port should 
> be minimal.

It would be nice if you could take a look at that (please see the "P.S." part):

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=84c21e254205ecac98f75b01589996440c6a6db0

> 
>   Maciej
> 
