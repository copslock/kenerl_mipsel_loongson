Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 May 2012 13:19:42 +0200 (CEST)
Received: from mga09.intel.com ([134.134.136.24]:33841 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903640Ab2EHLTh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 May 2012 13:19:37 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP; 08 May 2012 04:19:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; 
   d="asc'?scan'208";a="138156086"
Received: from linux.jf.intel.com (HELO linux.intel.com) ([10.23.219.25])
  by orsmga001.jf.intel.com with ESMTP; 08 May 2012 04:19:30 -0700
Received: from [10.237.72.159] (sauron.fi.intel.com [10.237.72.159])
        by linux.intel.com (Postfix) with ESMTP id 119136A4008;
        Tue,  8 May 2012 04:19:29 -0700 (PDT)
Message-ID: <1336476174.23308.32.camel@sauron.fi.intel.com>
Subject: Re: xway_nand does not build
From:   Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To:     John Crispin <blogic@openwrt.org>
Cc:     MIPS Mailing List <linux-mips@linux-mips.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>
Date:   Tue, 08 May 2012 14:22:54 +0300
In-Reply-To: <4FA8FF4C.5050400@openwrt.org>
References: <1336474838.23308.28.camel@sauron.fi.intel.com>
                 <4FA8FD24.6060908@openwrt.org>
         <1336475618.23308.30.camel@sauron.fi.intel.com>
         <4FA8FF4C.5050400@openwrt.org>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
        boundary="=-ntJ3kIXU1PPEY1rrLb4x"
X-Mailer: Evolution 3.2.3 (3.2.3-3.fc16) 
Mime-Version: 1.0
X-archive-position: 33195
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dedekind1@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>


--=-ntJ3kIXU1PPEY1rrLb4x
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-05-08 at 13:11 +0200, John Crispin wrote:
> That would be appreciated. i will get aligned with Ralf to make sure
> this patch flow via his tree

Feel free to add the following when you send to Ralf:

Acked-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

--=20
Best Regards,
Artem Bityutskiy

--=-ntJ3kIXU1PPEY1rrLb4x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABAgAGBQJPqQIOAAoJECmIfjd9wqK0SL0QAJOkcSNreolgiIYZD5nJBjL7
DBlS8vzfvH3TBhX8wd8TylVM7wLzuVgtKP2r/LsDN48Qzgod6ccswuNHresrCxgQ
O7k/dHZV921nbkVGLUqrLb4G8BbsTbI+Gx1hlS7EoJoOprJJ6N/SYdNvg7riSMxf
O3/5vXUspg+hcd0fjC2bPd/OVV93ZQx+lbaTRmmEZoPj9Dngj4blfnpW7yfOqmJs
9swnDWu4HsPWxgGvzYmqyPTehyXNrFrWe3p8cUa3VWtHFbBU3RTT2FzN0Doe/zZJ
1JwDDiXoBZFu2H2cuNjiXq3O+JzAC4DAjKrYXF03OWMh+R9BHCRJydS7T2osPub7
bHj+C7qDKB/O0Of+kE1EpHvELCUlWL5qx+7TdySm/fN5nQJSETU+o34pNlRaZBSv
/fZ8Z1tVr8AzI8lKREB67i4LQaSiTcxcn5MBlo+IA0yXLJT7CdpwWN9XNeTrH0jK
1OKIn4/P+e74evqiLYQf5uSxaya9TF9ug0BSu/TmHfQQNE5l56QhAiotkEMEK+pn
ZXPIG3ucun+e6hOyZXhri6HVDHlo8Zyo6Rgd/K+dA86C0iLopjkHd9r5Jj765F/w
FrAs5yLZ/Pk7GBqwd1dOam/YYkC5bhSecSXgRFKG/I2iRwqeV5SEDQMneZcRDd5J
eyFB2V8YMoDhypvOWzlQ
=s0vS
-----END PGP SIGNATURE-----

--=-ntJ3kIXU1PPEY1rrLb4x--
