Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Nov 2008 08:37:21 +0000 (GMT)
Received: from verein.lst.de ([213.95.11.210]:8328 "EHLO verein.lst.de")
	by ftp.linux-mips.org with ESMTP id S23324940AbYKGIhS (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 7 Nov 2008 08:37:18 +0000
Received: from verein.lst.de (localhost [127.0.0.1])
	by verein.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id mA78bDIF007478
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 7 Nov 2008 09:37:14 +0100
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id mA78bC25007473;
	Fri, 7 Nov 2008 09:37:12 +0100
Date:	Fri, 7 Nov 2008 09:37:12 +0100
From:	Christoph Hellwig <hch@lst.de>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: Re: [PATCH 05/29] MIPS: Add Cavium OCTEON processor support files to arch/mips/cavium-octeon/executive and asm/octeon.
Message-ID: <20081107083712.GA7205@lst.de>
References: <491358F5.7040002@caviumnetworks.com> <1226004875-27654-5-git-send-email-ddaney@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1226004875-27654-5-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.3.28i
X-Scanned-By: MIMEDefang 2.39
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21227
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
Precedence: bulk
X-list: linux-mips

Still lacks an explanation what the mess in the executive directory
actually does.  And as mentioned before I don't think any amount of
explanation would actually be enough for it, so please kill the mess
and write it as proper kernel code.
