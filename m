Received:  by oss.sgi.com id <S553753AbRCBIRS>;
	Fri, 2 Mar 2001 00:17:18 -0800
Received: from haliga.physik.TU-Cottbus.De ([141.43.75.9]:47885 "HELO
        haliga.physik.tu-cottbus.de") by oss.sgi.com with SMTP
	id <S553746AbRCBIRM>; Fri, 2 Mar 2001 00:17:12 -0800
Received: by haliga.physik.tu-cottbus.de (Postfix, from userid 7215)
	id 030228D67; Fri,  2 Mar 2001 09:17:10 +0100 (MET)
Date:   Fri, 2 Mar 2001 09:17:10 +0100
To:     linux-mips@oss.sgi.com
Subject: Re: NFSROOT filesystem
Message-ID: <20010302091710.B12824@physik.tu-cottbus.de>
References: <OF68B1111A.E5F36BC9-ON88256A02.0074F726@taec.toshiba.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <OF68B1111A.E5F36BC9-ON88256A02.0074F726@taec.toshiba.com>; from Lisa.Hsu@taec.toshiba.com on Thu, Mar 01, 2001 at 01:30:57PM -0800
From:   heinold@physik.tu-cottbus.de (H.Heinold)
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Mar 01, 2001 at 01:30:57PM -0800, Lisa.Hsu@taec.toshiba.com wrote:
> 
> Thanks to Henning for showing me where to get the big-endian compiled
> packages and it works.   Now, I need big-endian compiled "ash".
> Is anybody know where I can get it?
> 
> Thanks,
> 
> Lisa
> 

Hm why you need the ash? You can give the kernel the follwing via the
commandoline init=/bin/bash.
-- 


Henning Heinold
