Received:  by oss.sgi.com id <S553712AbQLENH0>;
	Tue, 5 Dec 2000 05:07:26 -0800
Received: from gandalf.physik.uni-konstanz.de ([134.34.144.69]:47880 "EHLO
        gandalf.physik.uni-konstanz.de") by oss.sgi.com with ESMTP
	id <S553652AbQLENHQ>; Tue, 5 Dec 2000 05:07:16 -0800
Received: from bilbo.physik.uni-konstanz.de [134.34.144.81] 
	by gandalf.physik.uni-konstanz.de with esmtp (Exim 3.12 #1 (Debian))
	id 143HoH-0004Qn-00; Tue, 05 Dec 2000 14:07:05 +0100
Received: from agx by bilbo.physik.uni-konstanz.de with local (Exim 3.12 #1 (Debian))
	id 143HoG-0007TL-00; Tue, 05 Dec 2000 14:07:04 +0100
Date:   Tue, 5 Dec 2000 14:07:04 +0100
From:   Guido Guenther <guido.guenther@uni-konstanz.de>
To:     Nicu Popovici <octavp@isratech.ro>
Cc:     linux-mips@oss.sgi.com
Subject: Re: X on ATLAS.
Message-ID: <20001205140704.C28457@bilbo.physik.uni-konstanz.de>
References: <3A2D310E.CA3BE148@isratech.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A2D310E.CA3BE148@isratech.ro>; from octavp@isratech.ro on Tue, Dec 05, 2000 at 01:16:47PM -0500
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi,
On Tue, Dec 05, 2000 at 01:16:47PM -0500, Nicu Popovici wrote:
> Does anyone know  something about running X on a mips machine ( ATLAS
> board + QEV processor ) ? Please try to give me a clue .
What kind of graphic hardware does the ATLAS board have. If you have 
a framebuffer device you should be able to get X(>=4.0.1) running fairly 
easily. 
 -- Guido
