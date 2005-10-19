Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Oct 2005 18:01:38 +0100 (BST)
Received: from web32614.mail.mud.yahoo.com ([68.142.207.241]:57481 "HELO
	web32614.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S3465662AbVJSRBO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 19 Oct 2005 18:01:14 +0100
Received: (qmail 85130 invoked by uid 60001); 19 Oct 2005 17:01:07 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.mx;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=XO8i4tuUpFWn20DmB1Hc8la4kcQgRZTYGuwYgGMJ57xry5ozbprmIKvmiEX/hG5rRzucTxWFdqaEKPTGl+BRvD2QKECUzoshdaxzOA3ggLoL1oikUhq+m2tqdCsQWNOzg9HjpOwv6fuzIJRsFolaihKVlqHIwDVrKrw8qjDtibY=  ;
Message-ID: <20051019170107.85128.qmail@web32614.mail.mud.yahoo.com>
Received: from [148.216.38.67] by web32614.mail.mud.yahoo.com via HTTP; Wed, 19 Oct 2005 12:01:07 CDT
Date:	Wed, 19 Oct 2005 12:01:07 -0500 (CDT)
From:	abraxas abraxas <abraxas_dragon@yahoo.com.mx>
Subject: problem about ISO C++...
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <abraxas_dragon@yahoo.com.mx>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9276
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abraxas_dragon@yahoo.com.mx
Precedence: bulk
X-list: linux-mips

Hi...

I have next problem. I have a PC (Petium IV) with
Debian 3.1 OS. I installed a cross-compiler for MIPS
architecture, the versión is 3.4.4, all instalation
was perferct. But when I try compile a code, to throw
some errores: 
-----------------------------------------
../include/ecc.h:7: error: `GF2E' does not name a type
../include/ecc.h:9: error: `GF2E' does not name a type
../include/ecc.h:11: error: expected `,' or `...'
before '&' token
../include/ecc.h:11: error: ISO C++ forbids
declaration of `GF2E' with no type
.
.
.
../include/ecc.h:21: error: `GF2E' does not name a
type
../include/ecc.h:30: error: `GF2X' has not been
declared
../include/ecc.h:31: error: ISO C++ forbids
declaration of `Phi' with no type
../include/ecc.h:33: error: `GF2E' has not been
declared
../include/ecc.h:33: error: `GF2E' has not been
declared
../include/ecc.h:34: error: ISO C++ forbids
declaration of `A' with no type
../include/ecc.h:34: error: ISO C++ forbids
declaration of `B' with no type
.
.
.
--------------------------------------------

Here this a content of file ecc.h:
::::::::::::::::::::::::::::::::::::::::::::::::::
#include <NTL/GF2XFactoring.h>
#include <NTL/GF2E.h>
#include <NTL/ZZ.h>

// Elliptic curve parameters

GF2E ec_A();

GF2E ec_B();

void ec_init(const GF2E& A, const GF2E& B);

void ec_init(GF2X Phi, long a, long b);


// Elliptic curve point
class ec_point {
public:

        unsigned infinity;
        GF2E x,y;

        ec_point() { infinity=0; x=y=0L;}

        ~ec_point() {}

        ec_point& operator=(const ec_point& P)
                { infinity=P.infinity; x=P.x; y=P.y;
return *this; }

        static void init(GF2X Phi, long a, long b)
                { ec_init(Phi,a,b); }

        static void init(GF2E A, GF2E B)
                { ec_init(A,B); }

};


// Comparison

inline unsigned IsOnEC(const ec_point& P)
{
        return
(P.infinity||(P.y*(P.y+P.x))==(P.x*P.x*(P.x+ec_A())+ec_B()));
}

inline unsigned IsInfinity(const ec_point& P)
{
  return (P.infinity);
};

inline unsigned operator==(const ec_point& P, const
ec_point& Q)
{
  return ((P.infinity==Q.infinity)||(P.x==Q.x &&
P.y==Q.y));
};
.
.
.
:::::::::::::::::::::::::::::::::::::::::::::::::::

What me more disconcerts me is the error:
error: ISO C++ forbids declaration of <...> with no
type.

Someone have any idea, why is it error?

Thank you for advanced.

Greeting!!!


	
	
		
___________________________________________________________ 
Do You Yahoo!? 
La mejor conexión a Internet y <b >2GB</b> extra a tu correo por $100 al mes. http://net.yahoo.com.mx 
