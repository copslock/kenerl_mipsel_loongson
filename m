Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Mar 2007 08:38:16 +0000 (GMT)
Received: from qb-out-0506.google.com ([72.14.204.229]:32105 "EHLO
	qb-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20022208AbXCMIiM (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 13 Mar 2007 08:38:12 +0000
Received: by qb-out-0506.google.com with SMTP id e12so4304896qba
        for <linux-mips@linux-mips.org>; Tue, 13 Mar 2007 01:37:07 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NBn8OEUXtwy+e3LV3chd0biZbmGue1ocO25HyXmAwZ6rxjM5dTz4Gp6saJFxwfeaTcPYdsWqd+kRBOzVXl48rUWDllWOAekCM8IwMyhzskgztMKQUhv4ZGvdHDoeyKuFcOoa+jFEvpa/9gIs2eFkJXEf4cUVxrl6qrXJ+wrV9Qk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fKsIvb0vhZeETdVPDSBX2sU+7EHmYZTAyJHjPPCzL/33I1IjRLnf1uOazc2ktBJbiXchSpU8OWbdUrPFxtT0bvA4zlWnb//4vKG5mpCtxmeGnTFXOsHDPuEPsA7hm75k22remxRCFHAC0YUgpMelkIHSQ6aGMksyMhxLXscimgY=
Received: by 10.115.17.1 with SMTP id u1mr2265146wai.1173775026685;
        Tue, 13 Mar 2007 01:37:06 -0700 (PDT)
Received: by 10.114.136.11 with HTTP; Tue, 13 Mar 2007 01:37:06 -0700 (PDT)
Message-ID: <cda58cb80703130137p39c46d8cr2dcd77ad57d4897e@mail.gmail.com>
Date:	Tue, 13 Mar 2007 09:37:06 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	post@pfrst.de
Subject: Re: [PATCH 0/2] FLATMEM: allow memory to start at pfn != 0 [take #2]
Cc:	linux-mips@linux-mips.org
In-Reply-To: <Pine.LNX.4.58.0703122016430.438@Indigo2.Peter>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <116841864595-git-send-email-fbuihuu@gmail.com>
	 <Pine.LNX.4.58.0703101034500.19007@Indigo2.Peter>
	 <cda58cb80703120247q435b6bb1p8a025d8597aca2a2@mail.gmail.com>
	 <Pine.LNX.4.58.0703121329450.440@Indigo2.Peter>
	 <cda58cb80703121005h53969eb2j7b2290b97b14374d@mail.gmail.com>
	 <Pine.LNX.4.58.0703122016430.438@Indigo2.Peter>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14445
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 3/12/07, peter fuerst <post@pfrst.de> wrote:
> On Mon, 12 Mar 2007, Franck Bui-Huu wrote:
> > Can you explain why the current use of pa() failed to handle all
> > kernel address with a real example ?
>
> Simply, when you convert between cached (kseg0, ckseg0, several xkphys-
> regions) and uncached (kseg1, ckseg1, several xkphys-regions) addresses
> and the other way round, you need the physical address as an intermediate
> value and __pa() or virt_to_phys() can support only one direction.
>

I was asking for _real_ uses. Can you point out some code where these
convertion are needed ?

I'm asking that because your uses of __pa()/virt_to_phys() to convert
cached address into uncached address and vice versa is weird. You
talked about drivers but I would think that drivers have physical
addresses of the device they control. And they get a virtual address
by using ioremap() and Co. And using __pa() on such addresses is
simply buggy whatever the implementation of __pa().
-- 
               Franck
