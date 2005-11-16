Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Nov 2005 01:44:35 +0000 (GMT)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:8416 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S8134014AbVKPBoS
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 16 Nov 2005 01:44:18 +0000
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id jAG1k9ir009156;
	Tue, 15 Nov 2005 17:46:09 -0800 (PST)
Received: from [192.168.236.16] (grendel [192.168.236.16])
	by mercury.mips.com (8.12.9/8.12.11) with ESMTP id jAG1k516015689;
	Tue, 15 Nov 2005 17:46:08 -0800 (PST)
Message-ID: <437A8FA1.8010404@mips.com>
Date:	Wed, 16 Nov 2005 02:47:13 +0100
From:	"Kevin D. Kissell" <kevink@mips.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Nguyen Thanh Binh <n_tbinh@yahoo.com>
CC:	linux-mips@linux-mips.org
Subject: Re: Calibrating delay loop... crashes
References: <20051116013634.74656.qmail@web30711.mail.mud.yahoo.com>
In-Reply-To: <20051116013634.74656.qmail@web30711.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.39
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9503
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

Nguyen Thanh Binh wrote:
> When booting Monta Vista Linux on Memec board
> (Virtex-4 FX12 LC), it crashed after printing the
> following message:
> 
>     "Calibrating delay loop..."
> 
> By looking at the source code, I found that in the
> init/main.c the problem came from the calibrate_delay
> function: jiffies was not incremented (jiffies was
> always equal to 0).
> 
> Have anyone get the similar problem or any experience
> to fix it?

I take it that by "crashed", you mean it hung?  If so,
it sounds like you aren't getting any timer interrupts.

		Regards,

		Kevin K.
