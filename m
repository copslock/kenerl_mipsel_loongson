Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Sep 2007 16:17:35 +0100 (BST)
Received: from rv-out-0910.google.com ([209.85.198.187]:22482 "EHLO
	rv-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20025788AbXIFPRZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 6 Sep 2007 16:17:25 +0100
Received: by rv-out-0910.google.com with SMTP id l15so138606rvb
        for <linux-mips@linux-mips.org>; Thu, 06 Sep 2007 08:17:05 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:x-spam-checker-version:x-spam-status:delivered-to:received:received:received:received-spf:received:received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:message-id:x-int-mailscanner-information:x-int-mailscanner:x-int-mailscanner-spamcheck:x-int-mailscanner-from:content-disposition:cc:content-type:content-transfer-encoding;
        bh=3czzzLz3IKZjOrDhN4MbzQO/d32BUO8AE96x+cvG8uY=;
        b=Q+HVsmDI84KvM2dS66O4i/fBTc6G7kT7P/NXkoxWsBY48ahI+kmMJ/633hBpsSl1x83X6rJLg7YI8Zqd6vv3fCUt4Fg+k7+jFrM3ovy1FM4h3DT9nEZNPCrEo3gPEO1DtejLIE3MgWtn9rW7elOCajGtKlgKuiGHdl533zsybDU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:x-spam-checker-version:x-spam-status:delivered-to:received-spf:from:to:subject:date:user-agent:references:in-reply-to:mime-version:message-id:x-int-mailscanner-information:x-int-mailscanner:x-int-mailscanner-spamcheck:x-int-mailscanner-from:content-disposition:cc:content-type:content-transfer-encoding;
        b=C4NpbZxP7NHwIKD5qFiUE7IxYBacQJqsB65i6osNWDlpEnI4mlm58yTQZkGMijWntNywzj4JmGI+Vhu5Ct+fUR8gVeyLF9+zK2H49RP3ntdKPtg37/jtfypx8x9CacoQB4I+f027qGdBDPeA25nNRYcpsCK9A6JcbgquSNoJhDY=
Received: by 10.140.170.12 with SMTP id s12mr293826rve.1189091825675;
        Thu, 06 Sep 2007 08:17:05 -0700 (PDT)
Received: from raver.cocorico ( [87.7.34.46])
        by mx.google.com with ESMTPS id h18sm13536423wxd.2007.09.06.08.17.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 06 Sep 2007 08:17:04 -0700 (PDT)
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
Subject: [PATCH][MIPS][0/7] AR7: third chance
Date:	Thu, 6 Sep 2007 17:16:59 +0200
User-Agent: KMail/1.9.7
References: <200708201704.11529.technoboy85@gmail.com>
In-Reply-To: <200708201704.11529.technoboy85@gmail.com>
MIME-Version: 1.0
Message-Id: <200709061716.59446.technoboy85@gmail.com>
X-int-MailScanner-Information: Please contact the ISP for more information
X-int-MailScanner: Found to be clean
X-int-MailScanner-SpamCheck: n'est pas un polluriel (inscrit sur la liste blanche),
	SpamAssassin (pas en cache, score=-1.467, requis 4.01,
	autolearn=not spam, AWL 1.00, BAYES_00 -2.60, FORGED_RCVD_HELO 0.14)
X-int-MailScanner-From:	florian.fainelli@telecomint.eu
Content-Disposition: inline
Cc:	nico@openwrt.org, nbd@openwrt.org, florian@openwrt.org
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-Path: <technoboy85@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16400
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
