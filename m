Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2008 18:46:04 +0000 (GMT)
Received: from verein.lst.de ([213.95.11.210]:50641 "EHLO verein.lst.de")
	by ftp.linux-mips.org with ESMTP id S22674729AbYJ2Sp4 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2008 18:45:56 +0000
Received: from verein.lst.de (localhost [127.0.0.1])
	by verein.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id m9TIjqIF032613
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 29 Oct 2008 19:45:52 +0100
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id m9TIjqCc032611;
	Wed, 29 Oct 2008 19:45:52 +0100
Date:	Wed, 29 Oct 2008 19:45:52 +0100
From:	Christoph Hellwig <hch@lst.de>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: Re: [PATCH 06/36] Add Cavium OCTEON processor CSR definitions
Message-ID: <20081029184552.GB32500@lst.de>
References: <490655B6.4030406@caviumnetworks.com> <1225152181-3221-1-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-2-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-3-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-4-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-5-git-send-email-ddaney@caviumnetworks.com> <1225152181-3221-6-git-send-email-ddaney@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1225152181-3221-6-git-send-email-ddaney@caviumnetworks.com>
User-Agent: Mutt/1.3.28i
X-Scanned-By: MIMEDefang 2.39
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21083
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
Precedence: bulk
X-list: linux-mips

On Mon, Oct 27, 2008 at 05:02:38PM -0700, David Daney wrote:
> Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
> Signed-off-by: David Daney <ddaney@caviumnetworks.com>
> ---
>  .../cavium-octeon/executive/cvmx-csr-addresses.h   | 8391 ++++++
>  arch/mips/cavium-octeon/executive/cvmx-csr-enums.h |   86 +
>  .../cavium-octeon/executive/cvmx-csr-typedefs.h    |27517 ++++++++++++++++++++

27517 lines in a header and it's all junk?  
