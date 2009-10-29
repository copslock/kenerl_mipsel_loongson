Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Oct 2009 06:51:15 +0100 (CET)
Received: from mail-qy0-f202.google.com ([209.85.221.202]:33527 "EHLO
	mail-qy0-f202.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1491957AbZJ2FvI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 29 Oct 2009 06:51:08 +0100
Received: by qyk40 with SMTP id 40so1014213qyk.22
        for <linux-mips@linux-mips.org>; Wed, 28 Oct 2009 22:51:01 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6wWCM0B20ZTvPjOzVZ2UE9MXnxt1GeAiAxcFGfJSiWc=;
        b=VKjbIuueaXcRTC40Sq3lQaXVY9CBgRL8zFg0fhyg7UbkZpCBZrWo9qpt7xOgAZjwzH
         NvHsov4e0+4RSVDohOPfk8LkwyphXkMSButAoXmcDtc41PSFBQOs95jKDQzgpsgPf3tm
         VgFhTWwTPRX/LxfcehFXzDKA5MAINZHnH7Kgw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dV6Nh4+O16uLwfLSFmuihpI/JFCmbcMbbcpG2elpQqwsvj0husYESiDeNGRpRtWAIX
         saX6BwTQuiMyAgG3N5KdHdIQIm7QqL6mS6V+IV8el/bgE755LhciMWn986Kxs2rvAPQo
         9Xod8kCVJ8Jux2k4n6dWGmtb1pfDJBKMhkZRY=
MIME-Version: 1.0
Received: by 10.220.122.100 with SMTP id k36mr12495125vcr.38.1256795461094; 
	Wed, 28 Oct 2009 22:51:01 -0700 (PDT)
In-Reply-To: <3a665c760910282048t3454e14bx431b035d2d3192b4@mail.gmail.com>
References: <3a665c760910270627u784d43b8t2978731110c920a4@mail.gmail.com>
	 <f284c33d0910272056n4cd082et2ba1a4b5e228bb0e@mail.gmail.com>
	 <3a665c760910272103gd4a6b78idb5e1175ba288b7e@mail.gmail.com>
	 <4AE865E5.2080008@caviumnetworks.com>
	 <3a665c760910282048t3454e14bx431b035d2d3192b4@mail.gmail.com>
Date:	Thu, 29 Oct 2009 11:21:01 +0530
Message-ID: <e3177630910282251s6feeadb3u6c98b261e4b00e57@mail.gmail.com>
Subject: Re: kernel panic about kernel unaligned access
From:	Anupam Kapoor <anupam.kapoor@gmail.com>
To:	loody <miloody@gmail.com>
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Mulyadi Santosa <mulyadi.santosa@gmail.com>,
	linux-mips <linux-mips@linux-mips.org>,
	Kernel Newbies <kernelnewbies@nl.linux.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <anupam.kapoor@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24573
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anupam.kapoor@gmail.com
Precedence: bulk
X-list: linux-mips

> Take  "8709ed20 writeback_inodes+0xb4/0x160" for example, what does
> 0x160, the last hex mean? The value of parameter?
first-number       i.e 0xb4   means that EIP was as many bytes into
the 'writeback_inodes' function when this happened.
second-number  i.e 0x160 mean that the function is '0x160' bytes long.

anupam
-- 
In the beginning was the lambda, and the lambda was with Emacs, and
Emacs was the lambda.
