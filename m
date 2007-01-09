Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Jan 2007 01:23:09 +0000 (GMT)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:59026 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S28575789AbXAIBXF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 9 Jan 2007 01:23:05 +0000
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Tue, 9 Jan 2007 10:23:04 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 9C8AE41812;
	Tue,  9 Jan 2007 10:23:01 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 9001D20268;
	Tue,  9 Jan 2007 10:23:01 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id l091N0W0029078;
	Tue, 9 Jan 2007 10:23:01 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Tue, 09 Jan 2007 10:23:00 +0900 (JST)
Message-Id: <20070109.102300.126576736.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, danieljlaird@hotmail.com
Subject: Re: [MIPS] PNX8550: Fix system timer support
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <S28574475AbXAHSAL/20070108180011Z+188138@ftp.linux-mips.org>
References: <S28574475AbXAHSAL/20070108180011Z+188138@ftp.linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13564
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 08 Jan 2007 18:00:06 +0000, linux-mips@linux-mips.org wrote:
> Author: Vitaly Wool <vitalywool@gmail.com> Thu Dec 28 17:14:05 2006 +0300
> Comitter: Ralf Baechle <ralf@linux-mips.org> Mon Jan 8 17:48:25 2007 +0000
> Commit: 390964852cbd7d5c589de60223d7cf73e9cbcdb9
> Gitweb: http://www.linux-mips.org/g/linux/39096485
> Branch: master
> 
> the patch inlined below restores proper time accounting for PNX8550-based
> boards. It also gets rid of #ifdef in the generic code which becomes
> unnecessary then.
> 
> It's functionally identical to the previous patch with the same name but
> it has minor comments from Atsushi and Sergei taken into account.

Please apply this patch too.  Daniel confirmed this patch fixes a long
hang on boot.

Subject: PNX8550: Fix system timer initialization

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

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
