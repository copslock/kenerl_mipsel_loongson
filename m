Received:  by oss.sgi.com id <S553813AbRBXKpg>;
	Sat, 24 Feb 2001 02:45:36 -0800
Received: from u-182-21.karlsruhe.ipdial.viaginterkom.de ([62.180.21.182]:62962
        "EHLO dea.waldorf-gmbh.de") by oss.sgi.com with ESMTP
	id <S553797AbRBXKpV>; Sat, 24 Feb 2001 02:45:21 -0800
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f1OAis605060;
	Sat, 24 Feb 2001 11:44:54 +0100
Date:   Sat, 24 Feb 2001 11:44:54 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jim Freeman <jfree@sovereign.org>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Redundant Configure.help entries?
Message-ID: <20010224114454.B3280@bacchus.dhis.org>
References: <20010223011625.A5748@sovereign.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010223011625.A5748@sovereign.org>; from jfree@sovereign.org on Fri, Feb 23, 2001 at 01:16:25AM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Feb 23, 2001 at 01:16:25AM -0700, Jim Freeman wrote:

> mips.cvs/Documentation/Configure.help has redundant
> CONFIG_DDB5074 entries ??

Just the CONFIG_* label was wrong.  Fixed.

  Ralf
