Received:  by oss.sgi.com id <S305175AbPLMVBn>;
	Mon, 13 Dec 1999 13:01:43 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:38484 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305163AbPLMVB1>;
	Mon, 13 Dec 1999 13:01:27 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id MAA18881; Mon, 13 Dec 1999 12:56:03 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA20780
	for linux-list;
	Mon, 13 Dec 1999 12:30:32 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA54819
	for <linux@engr.sgi.com>;
	Mon, 13 Dec 1999 12:30:25 -0800 (PST)
	mail_from (ealonso@alum.etsii.upm.es)
Received: from alum.etsii.upm.es (alum.etsii.upm.es [138.100.72.199]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id MAA06887
	for <linux@engr.sgi.com>; Mon, 13 Dec 1999 12:30:22 -0800 (PST)
	mail_from (ealonso@alum.etsii.upm.es)
Received: (qmail 28509 invoked by uid 33); 13 Dec 1999 20:28:18 -0000
Message-ID: <945116898.385556e277ae0@alum.etsii.upm.es>
Date:   Mon, 13 Dec 1999 21:28:18 +0100
To:     sgilinux <linux@cthulhu.engr.sgi.com>
From:   Enrique Alonso de Armas <ealonso@alum.etsii.upm.es>
Subject: linuxmips almost rules
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
User-Agent: IMP/PHP IMAP webmail program 2.2.0
X-Originating-IP: 138.100.73.23
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

Hi all.
    I have just installed Linux on an Indy 4600.
    I have selected 80 packages the minimun I think.

    The instalation was ok until the last options.
    I was no able to configure timezone, configure services, configure printers.

    Now when I boot from Irix ( boot vmlinux root=/dev/sdb1) , kernel loads and stops or
    appears to be stopped
    showing warning: mounting unchecked fs, running e2fsck is recomended
    The kernel is the one I used for installation. I mean It takes the IP from de bootp
    server.
    Ah and It says unable to open an initial console.
    It does not hung up it is like waiting
    Do I need other kernel without bootp?
    I can ping it

    Thak you in advance



----------------------------
Enrique Alonso de Armas
ealonso@disam.upm.es
http://www.alum.etsii.upm.es
Network/Unix System Admin
----------------------------
Type Bits/KeyID    Date       User ID
pub  1024/A83ECA45 1999/11/29 Enrique Alonso de Armas
<ealonso@disam.upm.es>
                              Enrique Alonso de Armas
<ealonso@alum.etsii.upm.es>

-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: 2.6.3ia

mQCNAzhCiGsAAAEEAM46AbktUPfljIASuu86r55404AcG/qOr5GzVCXlQbZxtYIH
tgjKIizZeT0rC0eftnj+nRvZwE6vFAllEM1dT0CRD2afEQToQKTWWbUCj6IEPICA
itF2kqD8DfOtyYd1lhiVkqKBnFT4ChCCkmhm/n/ZjwsZw1mpPReosEaoPspFAAUR
tC5FbnJpcXVlIEFsb25zbyBkZSBBcm1hcyA8ZWFsb25zb0BkaXNhbS51cG0uZXM+
iQCVAwUQOEKIaxeosEaoPspFAQFH4gP/SU13iEqKrM+8Rhxzv3mUizq5zWO8l4OX
FMi1XSuKhshCQ71L2EBT882y8brLmQRcjWjnrOG2LDqwMw5tm+DsaGrIZVedSwSi
P0h9OOxHc+QnfolISgscziJFGCLKbe91EiBUOCpFdNe95+GdwOsT1UrRkjpY72l7
QHLAL259sSm0M0VucmlxdWUgQWxvbnNvIGRlIEFybWFzIDxlYWxvbnNvQGFsdW0u
ZXRzaWkudXBtLmVzPokAlQMFEDhCi5oXqLBGqD7KRQEB/V4EALP/tBy22Q3aPkp+
68us9xi1ZJ1O4zmwmdWdJjP9ytwZDnQTJcg7kgPwF4Yprml8BlD5ygfplb9vCBgq
UhF4olyTHDFKh4PoimdkQh26ah0bBBmrQ9oYbcrI6kLzpjjr0f1NhQlXXzze9rNJ
XQaueEH0minGus9/qACAZYODfs+X
=grH6
-----END PGP PUBLIC KEY BLOCK-----
