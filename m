Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Nov 2009 15:22:13 +0100 (CET)
Received: from www.tglx.de ([62.245.132.106]:60512 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493427AbZKPOWG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 16 Nov 2009 15:22:06 +0100
Received: from localhost (www.tglx.de [127.0.0.1])
	by www.tglx.de (8.13.8/8.13.8/TGLX-2007100201) with ESMTP id nAGELWO3003415
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 16 Nov 2009 15:21:32 +0100
Date:	Mon, 16 Nov 2009 15:21:32 +0100 (CET)
From:	Thomas Gleixner <tglx@linutronix.de>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
cc:	rostedt@goodmis.org, Ralf Baechle <ralf@linux-mips.org>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Nicholas Mc Guire <der.herr@hofr.at>,
	David Daney <ddaney@caviumnetworks.com>,
	Richard Sandiford <rdsandiford@googlemail.com>,
	Patrik Kluba <kpajko79@gmail.com>,
	Michal Simek <monstr@monstr.eu>,
	"Maciej W . Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	zhangfx@lemote.com, zhouqg@gmail.com, Wu Zhangjin <wuzj@lemote.com>
Subject: Re: [PATCH v8 06/16] tracing: add an endian argument to
 scripts/recordmcount.pl
In-Reply-To: <3fcaffcfb3c8c8cd3015151ed5b7480ccaecde0f.1258177321.git.wuzhangjin@gmail.com>
Message-ID: <alpine.LFD.2.00.0911161520080.24119@localhost.localdomain>
References: <9dc81a7a9e5a292cccdf465c533a2b08d19d6021.1258177321.git.wuzhangjin@gmail.com> <b99c08397d9ff92ac5a72bda9131df41b702fc71.1258177321.git.wuzhangjin@gmail.com> <8f579e2cece16cd22358a4ec143ef6a8c462639b.1258177321.git.wuzhangjin@gmail.com>
 <ea337742d3ca7eec2825416041a6d4fa917d5cc4.1258177321.git.wuzhangjin@gmail.com> <7c7568247ad6cc109ec20387cfc3ca258d1d430f.1258177321.git.wuzhangjin@gmail.com> <3fcaffcfb3c8c8cd3015151ed5b7480ccaecde0f.1258177321.git.wuzhangjin@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: clamav-milter 0.95.1 at www.tglx.de
X-Virus-Status:	Clean
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24912
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

On Sat, 14 Nov 2009, Wu Zhangjin wrote:

> From: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> MIPS and some other architectures need this argument to handle
> big/little endian respectively.

Hmm, the patch adds the endian argument to the command line, but does
nothing else with it. Is there something missing from the patch or is
it just a left over from earlier iterations ?

Thanks,

	tglx
