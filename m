Received:  by oss.sgi.com id <S42219AbQGJWxm>;
	Mon, 10 Jul 2000 15:53:42 -0700
Received: from u-113.karlsruhe.ipdial.viaginterkom.de ([62.180.18.113]:62982
        "EHLO u-113.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42186AbQGJWxX>; Mon, 10 Jul 2000 15:53:23 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S640084AbQGJWxQ>;
        Tue, 11 Jul 2000 00:53:16 +0200
Date:   Tue, 11 Jul 2000 00:53:15 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Tor Arntsen <tor@spacetec.no>
Cc:     linux-mips@oss.sgi.com, linux-mips@vger.rutgers.edu,
        linux-mips@fnet.fr
Subject: Re: Kernel boot tips.
Message-ID: <20000711005315.A24256@bacchus.dhis.org>
References: <ralf@oss.sgi.com> <200007101355.PAA04630@pallas.spacetec.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200007101355.PAA04630@pallas.spacetec.no>; from tor@spacetec.no on Mon, Jul 10, 2000 at 03:55:34PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Jul 10, 2000 at 03:55:34PM +0200, Tor Arntsen wrote:

> This looks great. Just for fun I did a quick compile under irix 6.5.8 on 
> an SGI Octane, dvhtool --print-all and dvhtool --print-all /dev/rdsk/dksXXXvh 
> worked fine. --vh-to-unix failed with 'Short read: Error 0', I assume this 
> simply isn't finished yet (or maybe it doesn't work under irix).

It was actually developed under with gcc under IRIX and I can't even remember
having tested it under anything else.

It's a while that I last worked on it but as I remember --vh-to-unix was
actually working while the other direction was work in progress.

Maybe some nroff fan also wants to provide a manpage?

> BTW it compiled fine with gcc as well as with the MIPSPro compiler (after
> replacing this little gcc'ism:)

Patch applied.

  Ralf
