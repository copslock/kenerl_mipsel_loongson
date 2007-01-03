Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jan 2007 13:57:20 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:65499 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28573787AbXACN5R (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 3 Jan 2007 13:57:17 +0000
Received: from localhost (p3162-ipad31funabasi.chiba.ocn.ne.jp [221.189.127.162])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id D49C811C16; Wed,  3 Jan 2007 22:57:13 +0900 (JST)
Date:	Wed, 03 Jan 2007 22:57:13 +0900 (JST)
Message-Id: <20070103.225713.74752439.anemo@mba.ocn.ne.jp>
To:	danieljlaird@hotmail.com
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH][respin] pnx8550: fix system timer support
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <8127168.post@talk.nabble.com>
References: <8124491.post@talk.nabble.com>
	<20070103.010650.25910215.anemo@mba.ocn.ne.jp>
	<8127168.post@talk.nabble.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13540
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 2 Jan 2007 09:17:32 -0800 (PST), Daniel Laird <danieljlaird@hotmail.com> wrote:
> Thanks, thats the build problem removed, I now have a kernel that builds
> properly! (issues 1 and 2 appear to be closed)
> Only issue remaining is that I still have a long hang (10 seconds ish) 
> after this
> Memory: 53540k/57344k available (2156k kernel code, 3744k reserved, 383k
> data, 128k init, 0k highmem)
>  I am investigating but any help is appreciated...

Does this patch (on top of Vitaly's patch) solve remaining problem?

diff --git a/arch/mips/philips/pnx8550/common/time.c b/arch/mips/philips/pnx8550/common/time.c
index 08ebc3d..9d9fc71 100644
--- a/arch/mips/philips/pnx8550/common/time.c
+++ b/arch/mips/philips/pnx8550/common/time.c
@@ -80,6 +80,7 @@ void pnx8550_time_init(void)
 	 */
 	mips_hpt_frequency = 27UL * ((1000000UL * n)/(m * pow2p));
 	cpj = (mips_hpt_frequency + HZ / 2) / HZ;
+	write_c0_count(0);
 	timer_ack();
 
 	/* Setup Timer 2 */
