Received:  by oss.sgi.com id <S553776AbRAHQNR>;
	Mon, 8 Jan 2001 08:13:17 -0800
Received: from brutus.conectiva.com.br ([200.250.58.146]:3826 "EHLO
        dhcp046.distro.conectiva") by oss.sgi.com with ESMTP
	id <S553746AbRAHQNC>; Mon, 8 Jan 2001 08:13:02 -0800
Received: (ralf@lappi.waldorf-gmbh.de) by bacchus.dhis.org
	id <S870731AbRAHQDG>; Mon, 8 Jan 2001 14:03:06 -0200
Date:	Mon, 8 Jan 2001 14:03:04 -0200
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	Carsten Langgaard <carstenl@mips.com>
Cc:	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com,
        Michael Shmulevich <michaels@jungo.com>
Subject: Re: User applications
Message-ID: <20010108140304.A886@bacchus.dhis.org>
References: <3A598AFC.83204F56@mips.com> <3A59C0FB.62E52EF0@jungo.com> <00d801c0797d$5cc410c0$0deca8c0@Ulysses> <3A59CBB0.24160437@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A59CBB0.24160437@mips.com>; from carstenl@mips.com on Mon, Jan 08, 2001 at 03:16:16PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Jan 08, 2001 at 03:16:16PM +0100, Carsten Langgaard wrote:

> I think I just found it.
> The system call is sysmips(FLUSH_CACHE).

Don't.  Sysmips(FLUSH_CACHE, ...) only allows very coarse flush operation,
that is flushing all caches.  The whole sysmips(2) call exists in Linux
only as a stone age compatibility thing.

  Ralf
