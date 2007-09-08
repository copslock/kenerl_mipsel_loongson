Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Sep 2007 01:17:13 +0100 (BST)
Received: from ag-out-0708.google.com ([72.14.246.251]:43382 "EHLO
	ag-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S20025756AbXIHARE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 8 Sep 2007 01:17:04 +0100
Received: by ag-out-0708.google.com with SMTP id 33so301695agc
        for <linux-mips@linux-mips.org>; Fri, 07 Sep 2007 17:16:45 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:x-spam-checker-version:x-spam-status:delivered-to:received:received:received:received-spf:received:received:from:to:subject:date:user-agent:mime-version:message-id:x-int-mailscanner-information:x-int-mailscanner:x-int-mailscanner-spamcheck:x-int-mailscanner-from:content-disposition:cc:content-type:content-transfer-encoding;
        bh=6uGeF6Ewm9cDf4K3a8jMBSwHuRF5DKpl644Ii8/FkDg=;
        b=BsD08v3D6IiCZ7X9A1vE/Br5OnZub8bNxGP8qUC3eC1Pxe2NVUPyDXHk+fgRepkn5ZIV/VBbTjcijGEf35IUI5z15DPl0pynhKpunm6e9jGJDCrBXEzLYkmpx2kujl50kw7vsaOTQ/DkF78ZUCvg7PaggSpFLO/V2JOaejzQlwU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:x-spam-checker-version:x-spam-status:delivered-to:received-spf:from:to:subject:date:user-agent:mime-version:message-id:x-int-mailscanner-information:x-int-mailscanner:x-int-mailscanner-spamcheck:x-int-mailscanner-from:content-disposition:cc:content-type:content-transfer-encoding;
        b=gkD3ek1tZ6vZfoiK2bLA35MfOWXt0fwdQ0ftbnZXUTCZssgyBmFSpjiaWSvKvulCsf9KUygmbymKFDIYGRzsy55I9s+eJZ3YYB4qTMz4l0WcGletDoCrJpDKJ8Fc9iHi3cnyVxE24q19l4FWLIw6VgHd0o45Ya8iZvHktmmLPv0=
Received: by 10.90.49.1 with SMTP id w1mr4838540agw.1189210604985;
        Fri, 07 Sep 2007 17:16:44 -0700 (PDT)
Received: from raver.cocorico ( [87.12.226.15])
        by mx.google.com with ESMTPS id h13sm1533838wxd.2007.09.07.17.16.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 07 Sep 2007 17:16:43 -0700 (PDT)
Received: by 10.82.154.20 with SMTP id b20cs876037bue;
        Wed, 22 Aug 2007 01:11:04 -0700 (PDT)
Received: by 10.82.112.3 with SMTP id k3mr943124buc.1187770261340;
        Wed, 22 Aug 2007 01:11:01 -0700 (PDT)
Received: from smtp1.int-evry.fr (smtp1.int-evry.fr [157.159.10.44])
        by mx.google.com with ESMTP id j9si1357887mue.2007.08.22.01.10.56;
        Wed, 22 Aug 2007 01:11:01 -0700 (PDT)
Received-SPF: neutral (google.com: 157.159.10.44 is neither permitted nor denied by best guess record for domain of florian.fainelli@telecomint.eu) client-ip=157.159.10.44;
Received: from smtp-ext.int-evry.fr (smtp-ext.int-evry.fr [157.159.11.17])
	by smtp1.int-evry.fr (Postfix) with ESMTP id 122398E84F0;
	Wed, 22 Aug 2007 10:10:48 +0200 (CEST)
Received: from ibook.lan (mla78-1-82-240-16-241.fbx.proxad.net [82.240.16.241])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id 73CFED0E336;
	Wed, 22 Aug 2007 10:10:47 +0200 (CEST)
From:	Matteo Croce <technoboy85@gmail.com>
To:	linux-mips@linux-mips.org
Subject: [PATCH][MIPS][0/7] AR7: revised spellchecked and corrected
Date:	Sat, 8 Sep 2007 02:16:40 +0200
User-Agent: KMail/1.9.7
MIME-Version: 1.0
Message-Id: <200709080216.40390.technoboy85@gmail.com>
X-int-MailScanner-Information: Please contact the ISP for more information
X-int-MailScanner: Found to be clean
X-int-MailScanner-SpamCheck: n'est pas un polluriel (inscrit sur la liste blanche),
	SpamAssassin (pas en cache, score=-1.467, requis 4.01,
	autolearn=not spam, AWL 1.00, BAYES_00 -2.60, FORGED_RCVD_HELO 0.14)
X-int-MailScanner-From:	florian.fainelli@telecomint.eu
Content-Disposition: inline
Cc:	nico@openwrt.org, nbd@openwrt.org, florian@openwrt.org,
	openwrt-devel@lists.openwrt.org,
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-Path: <technoboy85@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16418
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: technoboy85@gmail.com
Precedence: bulk
X-list: linux-mips

These are patch for the AR7 router board:
core, serial hack, mtd partition map, ethernet, gpio pins, watchdog and leds
watchdog and cpmac doesn't works well and needs some changes
I CC'ed some people that would be interested

PS: If the patches are less than 7 than wait for the moderator to approve them (spam issues)
