Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2007 14:48:48 +0000 (GMT)
Received: from ug-out-1314.google.com ([66.249.92.169]:10659 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20022402AbXCWOsq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 23 Mar 2007 14:48:46 +0000
Received: by ug-out-1314.google.com with SMTP id 40so1144610uga
        for <linux-mips@linux-mips.org>; Fri, 23 Mar 2007 07:47:46 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uANX666OASnk9gl6sxwMeHoaJJ5NQUSAFksJMSCHQt8UW37x2/ysNyP4ADRd0MijvtkpyeUFdBdlzVe5OmMmvq9Zt1rXrDC5dQIBMZqGUnBIZ76iUS6jzJBcpnXR+o7ysrb6TSku05wsEn4qQr/5r/s+nOCuvKOYRcejwYkYPMA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WNvCXQArx4HG2YcLaC9+0TjkL2PdnPpJ+0LKdc1zglfhOj/DKjxo3Jq3BzccLmsCCcx7RODMTa4QjGy/maXj315rKXynE7Lu7qtoZZkpV3sh3llxGUEA/pVIYVEDdS7wtX3D2kivGvdquouILABlnhzI3/zbLym2qZUpYbO2lbk=
Received: by 10.114.155.1 with SMTP id c1mr1215320wae.1174661265294;
        Fri, 23 Mar 2007 07:47:45 -0700 (PDT)
Received: by 10.114.136.11 with HTTP; Fri, 23 Mar 2007 07:47:45 -0700 (PDT)
Message-ID: <cda58cb80703230747w524409d7m3ee7753e676b0683@mail.gmail.com>
Date:	Fri, 23 Mar 2007 15:47:45 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: flush_anon_page for MIPS
Cc:	"Miklos Szeredi" <miklos@szeredi.hu>, linux-mips@linux-mips.org,
	Ravi.Pratap@hillcrestlabs.com
In-Reply-To: <20070323141939.GB17311@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <E1HUVlw-00034H-00@dorka.pomaz.szeredi.hu>
	 <20070323141939.GB17311@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14628
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

On 3/23/07, Ralf Baechle <ralf@linux-mips.org> wrote:
> The other thing I still need to understand is why nobody actually seems
> to have triggered this bug on MIPS so far.  I suppose our implementation
> of flush_dcache_page() may have done a successful job at papering it
> which means there might be some performance getting lost there as well.
>

Just to understand, doesn't all mappings of shared anonymous pages and
kernel addresses of them share the same cache lines ?

thanks,
-- 
               Franck
