Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Jul 2009 22:32:10 +0200 (CEST)
Received: from mail.windriver.com ([147.11.1.11]:50062 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492819AbZGVUcD (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 22 Jul 2009 22:32:03 +0200
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id n6MKVRuO020311;
	Wed, 22 Jul 2009 13:31:27 -0700 (PDT)
Received: from ala-mail06.corp.ad.wrs.com ([147.11.57.147]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 22 Jul 2009 13:31:26 -0700
Received: from [172.25.32.45] ([172.25.32.45]) by ala-mail06.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 22 Jul 2009 13:31:26 -0700
Message-ID: <4A677722.2010203@windriver.com>
Date:	Wed, 22 Jul 2009 15:31:30 -0500
From:	Jason Wessel <jason.wessel@windriver.com>
User-Agent: Thunderbird 2.0.0.22 (X11/20090608)
MIME-Version: 1.0
To:	Wu Zhangjin <wuzhangjin@gmail.com>
CC:	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	ralf@linux-mips.org, Wu Zhangjin <wuzj@lemote.com>,
	Yan Hua <yanh@lemote.com>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	loongson-dev <loongson-dev@googlegroups.com>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>,
	Arnaud Patard <apatard@mandriva.com>
Subject: Re: [PATCH v4 02/16] [loongson] kgdb: Remove out-of-date board-specific
 source code
References: <cover.1246546684.git.wuzhangjin@gmail.com> <0e211b21ed263c482b3717e8feb9bd84e1a11839.1246546684.git.wuzhangjin@gmail.com>
In-Reply-To: <0e211b21ed263c482b3717e8feb9bd84e1a11839.1246546684.git.wuzhangjin@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Jul 2009 20:31:26.0931 (UTC) FILETIME=[6323B230:01CA0B0B]
Return-Path: <jason.wessel@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23767
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jason.wessel@windriver.com
Precedence: bulk
X-list: linux-mips

Wu Zhangjin wrote:
> From: Wu Zhangjin <wuzj@lemote.com>
>
> as the commit: 8854700115ecf8aa6f087aa915b7b6cf18090d39 shows, the new
> mips-specific kgdb implementation not need this board-specific source
> code, just remove it.
>
> Signed-off-by: Wu Zhangjin <wuzj@lemote.com>
>   

That should be the last of the dbg_io.c files.

Looks good to me.

Acked-by: Jason Wessel <jason.wessel@windriver.com>

Thanks,
Jason.
