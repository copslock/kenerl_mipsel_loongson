Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAEM7KT05793
	for linux-mips-outgoing; Wed, 14 Nov 2001 14:07:20 -0800
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAEM7G005790
	for <linux-mips@oss.sgi.com>; Wed, 14 Nov 2001 14:07:16 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id C9112125C0; Wed, 14 Nov 2001 14:07:14 -0800 (PST)
Date: Wed, 14 Nov 2001 14:07:14 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Geoffrey Espin <espin@idiom.com>
Cc: linux-mips-kernel@lists.sourceforge.net,
   linux-mips <linux-mips@oss.sgi.com>
Subject: Re: compiler problem
Message-ID: <20011114140714.A26099@lucon.org>
References: <1005591216.470.20.camel@zeus> <20011114134718.E16741@dea.linux-mips.net> <20011114132651.A85263@idiom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011114132651.A85263@idiom.com>; from espin@idiom.com on Wed, Nov 14, 2001 at 01:26:51PM -0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Nov 14, 2001 at 01:26:51PM -0800, Geoffrey Espin wrote:
> 
> I discovered that HJ Lu's toolchain seems to generate binaries
> sometimes nearly twice what I used to get with the old VR toolchain.
> Here are some of my apps (-static -stripped):
			    ^^^^^^^
> 
> OLD 'VR' tools
> 
>     -rwxr-xr-x    1 root     root       302384 Oct  4  2001 chat
>     -rwxr-xr-x    1 root     root       443848 Oct  4  2001 iptables
>     -r-sr-x---    1 root     root       619620 Oct  4  2001 pppd
>     -rwxr-xr-x    1 root     root       445788 Oct  4  2001 thttpd
>     -rwxr-xr-x    1 root     root       335560 Oct  4  2001 udhcpd
> 
> NEW gcc version 2.96 20000731
> 
>     -rwxr-xr-x    1 root     espin      543876 Nov 13 16:13 chat
>     -rwxr-xr-x    1 espin    espin      740092 Nov 13 16:13 iptables
>     -r-sr-x---    1 root     pppusers   907256 Nov 13 16:13 pppd
>     -rwxr-xr-x    1 espin    espin      703880 Nov 13 16:13 thttpd
>     -rwxr-xr-x    1 espin    espin      599200 Nov 13 16:13 udhcpd
> 
> 
> I guess this is most likely a glibc issue?

Yes. If you use -static, the binary will be bigger. If you want
smaller binaries, you should check out my sglibc.



H.J.
