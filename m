Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jan 2006 12:21:58 +0000 (GMT)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:60811 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S8133495AbWAPMVi
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 16 Jan 2006 12:21:38 +0000
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id k0GCOw53018813;
	Mon, 16 Jan 2006 04:24:58 -0800 (PST)
Received: from [192.168.236.16] (grendel [192.168.236.16])
	by mercury.mips.com (8.12.9/8.12.11) with ESMTP id k0GCOtYr014855;
	Mon, 16 Jan 2006 04:24:55 -0800 (PST)
Message-ID: <43CB9110.7040003@mips.com>
Date:	Mon, 16 Jan 2006 13:26:56 +0100
From:	"Kevin D. Kissell" <kevink@mips.com>
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To:	zhuzhenhua <zzh.hust@gmail.com>
CC:	Florian DELIZY <florian.delizy@sagem.com>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: =?ISO-8859-1?Q?R=E9f=2E_=3A_does_the_linux_kernel_?=
 =?ISO-8859-1?Q?use_k0=2C_k1_regs=3F?=
References: <OF4F21A98A.1F732941-ONC12570F8.00283714-C12570F8.0028B1BE@sagem.com> <50c9a2250601160401ifa8337cs2f8638f0077f37ed@mail.gmail.com>
In-Reply-To: <50c9a2250601160401ifa8337cs2f8638f0077f37ed@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.39
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9887
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

zhuzhenhua wrote:
> thanks for all
> now in my NMI interrupt, i first move k0 value to Desave, then use k0 to
> handle, and then eret.
> it can work.

It can work as long as you understand that you can't use
EJTAG breakpoints or (more difficult to avoid) handle DINT
events that happen during your NMI handler.

		Regards,

		Kevin K.
