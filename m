Received:  by oss.sgi.com id <S553655AbQLLQxe>;
	Tue, 12 Dec 2000 08:53:34 -0800
Received: from gandalf.physik.uni-konstanz.de ([134.34.144.69]:28943 "EHLO
        gandalf.physik.uni-konstanz.de") by oss.sgi.com with ESMTP
	id <S553647AbQLLQxP>; Tue, 12 Dec 2000 08:53:15 -0800
Received: from legolas.physik.uni-konstanz.de [134.34.144.84] 
	by gandalf.physik.uni-konstanz.de with esmtp (Exim 3.12 #1 (Debian))
	id 145sfx-0006N0-00; Tue, 12 Dec 2000 17:53:13 +0100
Received: from agx by legolas.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 145sft-0006Ia-00; Tue, 12 Dec 2000 17:53:09 +0100
Date:   Tue, 12 Dec 2000 17:53:09 +0100
From:   Guido Guenther <guido.guenther@gmx.net>
To:     linux-mips@oss.sgi.com
Subject: Re: latest xfree86
Message-ID: <20001212175309.A24195@legolas.physik.uni-konstanz.de>
References: <20001211210621.A32448@bilbo.physik.uni-konstanz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001211210621.A32448@bilbo.physik.uni-konstanz.de>; from guido.guenther@gmx.net on Mon, Dec 11, 2000 at 09:06:21PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Dec 11, 2000 at 09:06:21PM +0100, Guido Guenther wrote:
> Xnest is currently not building so you might want to add: 
> '#define XnestServer NO' to your xc/config/cf/host.def when building
> form source(or figure out why the build fails :).
Has been fixed. Patch can be found at:
http://honk/linux-mips/x/test/xnest.diff
 -- Guido
