Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAOKRlG03180
	for linux-mips-outgoing; Sat, 24 Nov 2001 12:27:47 -0800
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAOKRfo03167
	for <linux-mips@oss.sgi.com>; Sat, 24 Nov 2001 12:27:41 -0800
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id BC8F4125C3; Sat, 24 Nov 2001 11:25:47 -0800 (PST)
Date: Sat, 24 Nov 2001 11:25:47 -0800
From: "H . J . Lu" <hjl@lucon.org>
To: Carsten Langgaard <carstenl@mips.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: FPU test on RedHat7.1
Message-ID: <20011124112547.A22621@lucon.org>
References: <3BFD1BA7.C4490465@mips.com> <20011122103930.A2007@lucon.org> <3BFE6327.986D490C@mips.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BFE6327.986D490C@mips.com>; from carstenl@mips.com on Fri, Nov 23, 2001 at 03:54:31PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 23, 2001 at 03:54:31PM +0100, Carsten Langgaard wrote:
> The file sysdeps/ieee754/dbl-64/e_remainder.c seems to have changed since
> glibc-2.2.2.
> I have attached the glibc-2.2.2 remainder file, which seems to work
> better.
> 

I believe it is a MIPS FPU related issue. glibc tries to do

1.7976931348623157e+308 - 8.5720688574901386e+301 * 2097152

and expects -1.9958403095e+292. However, on mips, I got -inf. Could you
please look into it?

Thanks.


H.J.

--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ieee.c"

#include <stdio.h>

int main( int argc,char * argv[ ] )
{

  double res, d;
  
  union {
    unsigned long long l;
    double d;
  } op1, op2;

  op1.l = 0x7fefffffffffffffLL;
  op2.l = 0x7ea0000000000000LL;

  d = 2097152;
  res = op1.d - d * op2.d;

  printf("%llx\n", res);
  printf("%20.10e\n", res);

}

--sm4nu43k4a2Rpi4c--
