Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Mar 2007 19:32:47 +0000 (GMT)
Received: from ug-out-1314.google.com ([66.249.92.174]:5790 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20021629AbXCUTcq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 21 Mar 2007 19:32:46 +0000
Received: by ug-out-1314.google.com with SMTP id 40so487266uga
        for <linux-mips@linux-mips.org>; Wed, 21 Mar 2007 12:31:41 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g3nKzmuDnU2BR34QmK1blPXYCcxgGZWNJ9hUQqmdcdhYRqkH25P2zub4qxua0wVVPl71WJhV1T4p0K0VDpgok1daHoADBG+lh/a4ou8T939raGvEnj36YvfnSa+lu1M8oW0qhTKHQg3sJ62od5JivRD+4yImi0ESD9JEnnoLOdM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sq4/OxWpHJMac3+eVyOnLi70MyVSG69NhhONJYNp+RzF9Xl4dPcq02bUbVdYYJs0wMTswQ+Ez9F7gJPC5D8y25PkXRSehFtlRdo0ZSNFPr2suQ3X922x2kClKuxDBBJm56driP1uQ3GVntnGSDnmUSajCH1MB98MggdUQXJzoz8=
Received: by 10.114.110.1 with SMTP id i1mr286629wac.1174505500753;
        Wed, 21 Mar 2007 12:31:40 -0700 (PDT)
Received: by 10.114.136.11 with HTTP; Wed, 21 Mar 2007 12:31:40 -0700 (PDT)
Message-ID: <cda58cb80703211231u68e2f3b0g3a8a490a35f9d07f@mail.gmail.com>
Date:	Wed, 21 Mar 2007 20:31:40 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: Building 64 bit kernel on Cobalt
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20070322.020756.25910272.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070319.150705.100740532.nemoto@toshiba-tops.co.jp>
	 <cda58cb80703190308k4e57e194u56dca25b063646b6@mail.gmail.com>
	 <cda58cb80703190317h80cfd53x4acee55f2c757907@mail.gmail.com>
	 <20070322.020756.25910272.anemo@mba.ocn.ne.jp>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14613
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 3/21/07, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> On Mon, 19 Mar 2007 11:17:48 +0100, "Franck Bui-Huu" <vagabon.xyz@gmail.com> wrote:
> > > > You are using CONFIG_BUILD_ELF64=y and CKSEG0 load address.
> > > > This combination does not work.  Please refer these threads:
> > > >
> > >
> > > Thanks Atsushi for sorting this out. It's a bit sad to get these type
> > > of information after so many email echanges...
> > >
> >
> > BTW, how this config has ever worked for a 2.6.19 kernel ? I don't see
> > why using __pa() instead of CPHYSADDR() breaks this config...
>
> 2.6.19:
>         CPHYSADDR(0xffffffff80000000) == 0
>         __pa(0xffffffff80000000) == 0xffffffff80000000 - 0x9800000000000000
> 2.6.20 (CONFIG_BUILD_ELF64=y):
>         CPHYSADDR(0xffffffff80000000) == 0
>         __pa(0xffffffff80000000) == 0xffffffff80000000 - 0x9800000000000000
> 2.6.20 (CONFIG_BUILD_ELF64=n):
>         CPHYSADDR(0xffffffff80000000) == 0
>         __pa(0xffffffff80000000) == 0
>
> The reason is obvious, isn't it? ;)
>

Yes it is !

After writing this I just realised that I was confused by what you said earlier:

    You are using CONFIG_BUILD_ELF64=y and CKSEG0 load address.
    This combination does not work.  Please refer these threads:

This combo should theoritically work but currently does not. Unlike
the following one

    CONFIG_BUILD_ELF64=n and XKPHYS load address.

which definitely don't work. And I mixed the second case with the first one...

no other comment ;)
-- 
               Franck
