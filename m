Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Aug 2007 18:02:45 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.175.29]:35050 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20022579AbXHMRCf (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 13 Aug 2007 18:02:35 +0100
Received: from localhost (p1166-ipad311funabasi.chiba.ocn.ne.jp [123.217.211.166])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id D200CA660; Tue, 14 Aug 2007 02:01:15 +0900 (JST)
Date:	Tue, 14 Aug 2007 02:02:29 +0900 (JST)
Message-Id: <20070814.020229.29578157.anemo@mba.ocn.ne.jp>
To:	vagabon.xyz@gmail.com
Cc:	linux-mips@linux-mips.org
Subject: Re: [MIPS] Use generic NTP code for all MIPS platforms
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <46C07F36.1070308@gmail.com>
References: <S20023068AbXHMO0W/20070813142622Z+9352@ftp.linux-mips.org>
	<20070814.003242.59465104.anemo@mba.ocn.ne.jp>
	<46C07F36.1070308@gmail.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16163
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Mon, 13 Aug 2007 17:56:38 +0200, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> > I think there are no point using GENERIC_CMOS_UPDATE for users of the
> > new-style RTC_CLASS drivers or platforms with no RTC.
> 
> But how the new-style RTC drivers get updated ?

IIUC for now there are no kernel-mode NTP syncronization for new style
RTC drivers.  (Please correct me if I was wrong)

---
Atsushi Nemoto
