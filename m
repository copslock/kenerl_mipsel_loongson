Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Sep 2007 14:50:09 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.170]:51070 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20029274AbXI0NuB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 27 Sep 2007 14:50:01 +0100
Received: by ug-out-1314.google.com with SMTP id u2so1525323uge
        for <linux-mips@linux-mips.org>; Thu, 27 Sep 2007 06:49:43 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=NtYg22JRRPTVnwI5s4gU8HlnCDPs/TJqCCs+SUQT+iI=;
        b=cvXrjIqJ1O+RBE79FBS9yq4endHa1h5l6oaN0oFKFc3ssVARG8rGRdm7aUKDz98tBf3D7dQKKgDVx+myZzPj12reJEaHZAkn8Fvtrqh+EYKLDg0+1ZlOjR+YLQEF4VHUZJcB0P8Lj9YYefv9NvQXYW336pIcg18Pco4T5KpGzFc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=UrIZyifpCK5Qss2/B8V/uK8DKfDL9lAsum+sUoRehMNXHT+WMC7Rtoj7M/sEsRadgw8GZmqPxcQtISAKWS1IEwyUOqoeywrGZsjEeoVW0XR4N/usG0Tf2EIOnwxVv9ralDlzLgAF/AnGP8PHmz/mpUlePW/+vwkGmaZtuxHfvyk=
Received: by 10.67.19.11 with SMTP id w11mr3582233ugi.1190900982345;
        Thu, 27 Sep 2007 06:49:42 -0700 (PDT)
Received: from ?192.168.0.1? ( [82.235.205.153])
        by mx.google.com with ESMTPS id j12sm4510347fkf.2007.09.27.06.49.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 27 Sep 2007 06:49:42 -0700 (PDT)
Message-ID: <46FBB47B.8030500@gmail.com>
Date:	Thu, 27 Sep 2007 15:47:39 +0200
From:	Franck Bui-Huu <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, tbm@cyrius.com,
	linux-mips@linux-mips.org
Subject: Re: CONFIG_BUILD_ELF64 broken on IP32 since 2.6.20
References: <Pine.LNX.4.64N.0709261226340.30122@blysk.ds.pg.gda.pl> <46FA5FFA.1060704@gmail.com> <Pine.LNX.4.64N.0709261525510.30122@blysk.ds.pg.gda.pl> <20070927.003400.108121785.anemo@mba.ocn.ne.jp> <Pine.LNX.4.64N.0709261644500.30122@blysk.ds.pg.gda.pl> <46FB65C5.2000202@gmail.com> <20070927133606.GA9562@linux-mips.org>
In-Reply-To: <20070927133606.GA9562@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16715
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> -msym32 and previously the strategy to tell the compiler to generate 64-bit
> code but the assembler to put it into 32-bit ELF was initially a hack
> to get around the lack of proper 64-bit binutils support and later 
> turned into a neat optimization with significant code size savings.  But
> it's really just an optimization so there is nothing wrong with just
> dropping the option (and whatever else goes along with it, I forgot all
> the nasty details) on the floor if due to a vintage compiler it can't be
> suported.
> 

ok, I'll send a patch to reflect that.

		Franck
