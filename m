Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jun 2009 12:56:51 +0100 (BST)
Received: from mail-ew0-f219.google.com ([209.85.219.219]:55949 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20025117AbZFAL4p (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 1 Jun 2009 12:56:45 +0100
Received: by ewy19 with SMTP id 19so8025602ewy.0
        for <multiple recipients>; Mon, 01 Jun 2009 04:56:39 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:subject:date
         :user-agent:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=gfHhlnymr3TEis5n9yXkOXlKZee1k3gN31jtxHDB+iY=;
        b=PgvKofoEdocUQaEfj/YgQ7roz9HgvBcrqcemivjLSVPSPeKCPzkQtRx9uUwITmpgS5
         GedgOJ5lWDFxOWxtiPYuFGtS+8ZeVDV68Y+emdNam0jvEO8a+qTsbCgGHCqe8qjQ2cyB
         YwheAOeSQPSxJ1oAjKd5NThwdLwiHScgRPjZA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=mcQXpfRI1J3OEECnpVpd27mMBWn2MQ/f1FufYa5ash1o1aPAHA3Y/vjjdOl4yvb7Mv
         Gpsk0D1AO5lBvwqURdJXS7vpRE3/ks/b9jMtbMhDiw+JU3YuE5wqqe1jtpI44qHUZF0e
         yrzufH6tfQzoKvRnwLjBRHLydIJ79o6iEuo04=
Received: by 10.210.35.5 with SMTP id i5mr6277716ebi.49.1243857393786;
        Mon, 01 Jun 2009 04:56:33 -0700 (PDT)
Received: from florian.lab.openpattern.org (lab.openpattern.org [82.240.16.241])
        by mx.google.com with ESMTPS id 28sm7277073eye.16.2009.06.01.04.56.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Jun 2009 04:56:32 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	openwrt-devel@lists.openwrt.org
Subject: [PATCH 0/9] Resubmission of the AR7 port
Date:	Mon, 1 Jun 2009 13:56:29 +0200
User-Agent: KMail/1.9.9
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200906011356.29943.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23103
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This is a resubmission of the AR7 port. I have taken into
account comments from the previous thread here: http://www.linux-mips.org/archives/linux-mips/2007-09/msg00005.html

The following patches are splitted like this:

1 : export the sound/core/pcm_timer.c gcd implementation, also used by the AR7 clock routines
2 : add support for TI's VLYNQ bus
3 : wire in the VLYNQ bus support in drivers/
4 : MIPS: deal with larger physical offsets
5 : serial: add support for the TI AR7 internal UART
6 : serial: workaround TI AR7 silicon bug
7 : MIPS: add TI AR7 support
8 : MIPS: add ar7_defconfig
9 : MIPS: wire in AR7 support

Thanks
-- 
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------
