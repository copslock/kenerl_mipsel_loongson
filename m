Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jan 2006 13:14:13 +0000 (GMT)
Received: from webapps.arcom.com ([194.200.159.168]:14597 "EHLO
	webapps.arcom.com") by ftp.linux-mips.org with ESMTP
	id S8133428AbWAJNNy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 10 Jan 2006 13:13:54 +0000
Received: from [10.2.2.14] ([10.2.2.14]) by webapps.arcom.com with Microsoft SMTPSVC(6.0.3790.211);
	 Tue, 10 Jan 2006 13:20:42 +0000
Message-ID: <43C3B3C3.6080204@cantab.net>
Date:	Tue, 10 Jan 2006 13:16:51 +0000
From:	David Vrabel <dvrabel@cantab.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Thomas Dahlmann <thomas.dahlmann@amd.com>
CC:	Oliver Neukum <oliver@neukum.org>,
	linux-usb-devel@lists.sourceforge.net,
	Jordan Crouse <jordan.crouse@amd.com>,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
	info-linux@ldcmail.amd.com
Subject: Re: [linux-usb-devel] [PATCH] UDC support for MIPS/AU1200 and Geode/CS5536
References: <20060109180356.GA8855@cosmic.amd.com> <200601092344.55988.oliver@neukum.org> <43C39431.6020308@amd.com>
In-Reply-To: <43C39431.6020308@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Jan 2006 13:20:42.0578 (UTC) FILETIME=[A83CA320:01C615E8]
Return-Path: <dvrabel@cantab.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9837
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvrabel@cantab.net
Precedence: bulk
X-list: linux-mips

Thomas Dahlmann wrote:
> 
> The loop is for reading dwords only, so "i < bytes / UDC_DWORD_BYTES" cuts
> off remaining 1,2 or 3 bytes which are handled by the next loop.
> But you are right, incrementing by 4 may look better,  as
> 
>        for (i = 0; i < bytes - bytes % UDC_DWORD_BYTES; i+=4) {

    for (i = 0; i <= bytes - UDC_DWORD_BYTES; i += 4) {

?

David Vrabel
