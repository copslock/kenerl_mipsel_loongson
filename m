Received:  by oss.sgi.com id <S553807AbQLSRv4>;
	Tue, 19 Dec 2000 09:51:56 -0800
Received: from brutus.conectiva.com.br ([200.250.58.146]:22510 "EHLO
        dhcp046.distro.conectiva") by oss.sgi.com with ESMTP
	id <S553799AbQLSRvo>; Tue, 19 Dec 2000 09:51:44 -0800
Received: (ralf@lappi) by bacchus.dhis.org id <S867579AbQLSRr7>;
	Tue, 19 Dec 2000 15:47:59 -0200
Date:	Tue, 19 Dec 2000 15:47:59 -0200
From:	Ralf Baechle <ralf@oss.sgi.com>
To:	Carsten Langgaard <carstenl@mips.com>
Cc:	linux-mips@oss.sgi.com
Subject: Re: 64 bit build fails
Message-ID: <20001219154759.A6566@bacchus.dhis.org>
References: <3A379CBC.ED1D9F@mips.com> <20001214215933.C28871@bacchus.dhis.org> <3A39CC1F.8FE7B2FE@mips.com> <20001215162023.B28594@bacchus.dhis.org> <3A3DC6BA.DAC68261@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3A3DC6BA.DAC68261@mips.com>; from carstenl@mips.com on Mon, Dec 18, 2000 at 09:11:38AM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Mon, Dec 18, 2000 at 09:11:38AM +0100, Carsten Langgaard wrote:

> Of course some time it is a little bit annoying you doesn't just accept
> my patches :-)  Just kidding, I think that's the right way to do things.

Actually I tried to apply the patch but patch thinks your patch isn't a valid
patch file ...

> I was just hoping that the 64bit code was in the same condition as the
> rest of the code.

Depends.  It's running fairly well on Origins; nobody made a more than
halfbreed attempt to support IP22 for mips64, so what you see was kind of
what had to be expected.

  Ralf
