Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Nov 2009 17:58:37 +0100 (CET)
Received: from mail-pz0-f197.google.com ([209.85.222.197]:63090 "EHLO
	mail-pz0-f197.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493426AbZKPQ6a (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 16 Nov 2009 17:58:30 +0100
Received: by pzk35 with SMTP id 35so4570751pzk.22
        for <multiple recipients>; Mon, 16 Nov 2009 08:58:24 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=2lD4eRlCOvUZirgOcDRgGca0qotyxhTrJadVldN+fdQ=;
        b=DPRewF7vpA3psPtdZjEKcVjFPFnjSKq9ODpFQptENKCTL8NzazvZ5T0zzhDT61Earb
         TkgR14/UdYaicv9Ikk8Yo2ipYWtlFtvJcOpAq1DJrvHNqE6yxDfmziXB9hW4N3VIyKzS
         4Fs2/XZrTNPlOXTTfiWd4DGpQFoRoaVSp4Pxw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=hLpyxE8TF5vcBwafOXYp1WmeE5HrQAeTXgU0jY10w2JmilLuxwHoK495fTj+ZCJkWr
         YJTS+PrLdJApW/Fv6pJpBSd/mwmgqG9rdexahX9W2AvVYY6TNnREl7IXn483scdIZU0q
         448REVtczR9aLj4gDFYOTHKNQQ8D61+Qgf8dY=
Received: by 10.114.214.24 with SMTP id m24mr6021750wag.93.1258390704091;
        Mon, 16 Nov 2009 08:58:24 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 23sm4349128pxi.5.2009.11.16.08.58.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Nov 2009 08:58:23 -0800 (PST)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org, Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH 0/2] Add Lemote NAS and Lynloong support
Date:	Tue, 17 Nov 2009 00:58:13 +0800
Message-Id: <cover.1258390323.git.wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24922
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

The following two patches add support for NAS & Lynloong made by Lemote, These
two machines are basically the same as fuloong2f, only a few part of
differences.

Hi, Ralf, Could you please queue them to 2.6.33? I will delay the left drivers
to 2.6.34.

Thanks & Regards,
	Wu Zhangjin

Wu Zhangjin (2):
  loongson: lemote-2f: add NAS support
  loongson: lemote-2f: add lynloong support

 arch/mips/include/asm/bootinfo.h      |    4 +++-
 arch/mips/loongson/common/machtype.c  |    2 ++
 arch/mips/loongson/common/serial.c    |    2 ++
 arch/mips/loongson/common/uart_base.c |    2 ++
 arch/mips/loongson/lemote-2f/reset.c  |    4 ++++
 5 files changed, 13 insertions(+), 1 deletions(-)
