Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Feb 2007 08:38:00 +0000 (GMT)
Received: from qb-out-0506.google.com ([72.14.204.227]:55368 "EHLO
	qb-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20037755AbXBZIhz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 26 Feb 2007 08:37:55 +0000
Received: by qb-out-0506.google.com with SMTP id e12so776289qba
        for <linux-mips@linux-mips.org>; Mon, 26 Feb 2007 00:36:54 -0800 (PST)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ElZ228PkwGYcxN1ya12tsNU1RLxm/boxC6KoEcG+S6h3Cu7wB4SryA5aW34qrp5/ZzIASob5QRn6D5OQSM/4F7jWCNKE9CVCgkIqKLs0k9DnVm7yMx2UNKlfJfBcTgqhJ3H2p1FVk2N2FG0pyVhz4N9OaoJwCt0mmNmCe3/6mcg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=K99DZpIeAfVUVlEWKnLNNBOp6JsnQNJj8+pcS3UiBbI9xGl8B+3lhUkxa69x1KZyvZgb45DE/LerOQ8BxQ6Wynu2Zf28pg8DcuyPa8KqhFmDkpVzLV76QGtchB3a77EFtjNlHD/LGuvDk0dLZZeGtf7GSXdq1ojKiQm/3ZV6fys=
Received: by 10.114.122.2 with SMTP id u2mr2003254wac.1172479013683;
        Mon, 26 Feb 2007 00:36:53 -0800 (PST)
Received: by 10.114.136.11 with HTTP; Mon, 26 Feb 2007 00:36:53 -0800 (PST)
Message-ID: <cda58cb80702260036r4a93033i51b1b135b96f189d@mail.gmail.com>
Date:	Mon, 26 Feb 2007 09:36:53 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: [RFC] Add basic SMARTMIPS ASE support
Cc:	linux-mips <linux-mips@linux-mips.org>
In-Reply-To: <20070220220210.GA10404@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45C369CB.2040400@innova-card.com>
	 <20070220220210.GA10404@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14243
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 2/20/07, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Fri, Feb 02, 2007 at 05:41:47PM +0100, Franck Bui-Huu wrote:
>
> > From: Franck Bui-Huu <fbuihuu@gmail.com>
> >
> > This patch adds trivial support for SMARTMIPS extension. This
> > extension is currently implemented by 4KS[CD] CPUs.
>
> The SmartMIPS ASE according to the spec is explicitly for MIPS32, so I'm
> stripping the 64-bit kernel bits of it.  I also did a bit of Kconfig
> polishing to make SmartMIPS selectable on those platforms which might
> actually have such a CPU only, that is currently all the FPGA-based
> platforms, Altas, SEAD and Malta.
>

Thanks for polishing.

BTW, 'linux-2.6.21-rc1' tag is missing in your repo.
-- 
               Franck
