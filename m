Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Dec 2010 17:10:30 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:41896 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493015Ab0LAQK1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Dec 2010 17:10:27 +0100
Received: by fxm19 with SMTP id 19so2309195fxm.36
        for <multiple recipients>; Wed, 01 Dec 2010 08:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=b2wl2OXN96Nnesn+x2RTBvfHL8ZGUeHbQrMRo7SWEos=;
        b=TZ+wkS10Dh46UnNDPey2xGqXoKB4s4gwLiXG0ZlW8tW4NZuG9pMt8dEA8JbZr7ulT0
         l4RJFF2EIByLVrflft4jF0QHS6jNp0yaEQcK4gTaa7E55yl8k7adQp5+HP59yaeAZZTq
         ZxOlgJMgF9mvudWSjiwtiZ53FqVIC+sgzxTLA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=Jsm9cyofeR2MQFTVDXA/+YksOQ0Ig6IlbwXquOeH+891i1juA6HmqK5oXFkFrvoHqG
         gf2Tgb6Q9/Hp5NHiSlyPzGpYyFacIcZps/C9rkl6DdYbrr6JD08x7xGU+qh5RR43YcII
         F3wm+yirwAj1cnVitOU4nDx8PR3nNE8ifz6GU=
Received: by 10.223.108.147 with SMTP id f19mr8473446fap.68.1291219821392;
        Wed, 01 Dec 2010 08:10:21 -0800 (PST)
Received: from [172.16.48.51] ([59.160.135.215])
        by mx.google.com with ESMTPS id a24sm938953fak.3.2010.12.01.08.10.17
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Dec 2010 08:10:20 -0800 (PST)
Subject: Subject: [RFC 0/3] VSMP support for msp71xx platforms
From:   Anoop P A <anoop.pa@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, mcdonald.shane@gmail.com,
        "Kevin D. Kissell" <kevink@paralogos.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Wed, 01 Dec 2010 21:43:11 +0530
Message-ID: <1291219991.31413.8.camel@paanoop1-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Content-Transfer-Encoding: 7bit
Return-Path: <anoop.pa@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28584
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anoop.pa@gmail.com
Precedence: bulk
X-list: linux-mips

>From 5bfd3ba210e521df2b493862446b4535bcdb0cdf Mon Sep 17 00:00:00 2001
Message-Id: <cover.1291219118.git.anoop.pa@gmail.com>
From: Anoop P A <anoop.pa@gmail.com>
Date: Wed, 1 Dec 2010 21:28:38 +0530
Subject: [RFC 0/3] VSMP support for msp71xx platforms
Cc: anoop.pa@gmail.com

Following series patches add VSMP support for MSP71xx series of SoC's.


Anoop P A (3):
  VSMP support for msp71xx family of platforms.
  SMP support MSP CIC and PER cascaded interrupt subsystem.
  VSMP support for MSP71xx family.

 arch/mips/pmc-sierra/msp71xx/Makefile      |    3 +-
 arch/mips/pmc-sierra/msp71xx/msp_irq.c     |   49 +++++-
 arch/mips/pmc-sierra/msp71xx/msp_irq_cic.c |  245
+++++++++++++++++++---------
 arch/mips/pmc-sierra/msp71xx/msp_irq_per.c |  175 ++++++++++++++++++++
 arch/mips/pmc-sierra/msp71xx/msp_setup.c   |    3 +
 arch/mips/pmc-sierra/msp71xx/msp_smp.c     |   75 +++++++++
 arch/mips/pmc-sierra/msp71xx/msp_time.c    |    2 +-
 7 files changed, 463 insertions(+), 89 deletions(-)
 create mode 100644 arch/mips/pmc-sierra/msp71xx/msp_irq_per.c
 create mode 100644 arch/mips/pmc-sierra/msp71xx/msp_smp.c
