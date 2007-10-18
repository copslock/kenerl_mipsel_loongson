Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Oct 2007 22:13:59 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.186]:64521 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20043413AbXJRVNv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 18 Oct 2007 22:13:51 +0100
Received: by nf-out-0910.google.com with SMTP id c10so259827nfd
        for <linux-mips@linux-mips.org>; Thu, 18 Oct 2007 14:13:51 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=tbdf1sMFGedltSx3wO9p+d1EAbiA5LEF3qeyVSqjskY=;
        b=gujCpFxeVbWK9Jtau+RWa0cSdDPon/24TzUcNmLcFoEOtBr720XXUzoOWamBvo9BhJRNLGmhzDZehkTtvikTvltfYk2e6txPHi6Ktibp1fbp7J4Ba46Zb2HxavLP3d0aqbOjMJsFRCmV69SE6+L0CmuthEpBuenVq7FmZfRF8qc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=WLWm1RrP45Pd0FkFTzo2j9LwyRdoxP0fRcbQtXFALz0K5+C/Hm6oQyNMa3/U43fGge1YG4dfROQ2soGg6U9kQJLLvVldhL3C4PJvBSMfl1VvcloEqKyXK6h/JcKWUBMVrxIw+qO+iL7aowtK96r9Ws00ghqxRFm+pRjDfTVichg=
Received: by 10.86.66.1 with SMTP id o1mr777451fga.1192742030982;
        Thu, 18 Oct 2007 14:13:50 -0700 (PDT)
Received: from localhost ( [82.235.205.153])
        by mx.google.com with ESMTPS id f31sm2432825fkf.2007.10.18.14.13.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 18 Oct 2007 14:13:50 -0700 (PDT)
From:	Franck Bui-Huu <fbuihuu@gmail.com>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org, macro@linux-mips.org
Subject: [RFC] Add .bss.{init,exit} sections [take #2]
Date:	Thu, 18 Oct 2007 23:12:29 +0200
Message-Id: <1192741953-7040-1-git-send-email-fbuihuu@gmail.com>
X-Mailer: git-send-email 1.5.3.4
Return-Path: <fbuihuu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17119
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fbuihuu@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

It seems to magically work fine now. The init.bss section have been
renamed into .bss.init so GCC makes that section with nobits attribute.

I'm really not confident with these changes so if someone could
double check that would be great. Maybe it's time for asking some
advices to binutils mailing list ?

		Franck
