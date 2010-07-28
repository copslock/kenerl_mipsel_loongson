Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jul 2010 22:47:37 +0200 (CEST)
Received: from rtp-iport-1.cisco.com ([64.102.122.148]:35553 "EHLO
        rtp-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492801Ab0G1Urb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Jul 2010 22:47:31 +0200
Authentication-Results: rtp-iport-1.cisco.com; dkim=neutral (message not signed) header.i=none
X-Files: 8KG6-DeviceTree-512MB.dts : 1615
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAJs0UEytJV2c/2dsb2JhbACgB3GnW5sKhTYEhA6EB4MXDAE
X-IronPort-AV: E=Sophos;i="4.55,275,1278288000"; 
   d="dts'?scan'208";a="140428968"
Received: from rcdn-core-5.cisco.com ([173.37.93.156])
  by rtp-iport-1.cisco.com with ESMTP; 28 Jul 2010 20:47:24 +0000
Received: from xbh-rcd-101.cisco.com (xbh-rcd-101.cisco.com [72.163.62.138])
        by rcdn-core-5.cisco.com (8.14.3/8.14.3) with ESMTP id o6SKlObR029365;
        Wed, 28 Jul 2010 20:47:24 GMT
Received: from xmb-rcd-208.cisco.com ([72.163.62.215]) by xbh-rcd-101.cisco.com with Microsoft SMTPSVC(6.0.3790.4675);
         Wed, 28 Jul 2010 15:47:24 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="----_=_NextPart_001_01CB2E96.148AEE28"
Subject: RE: [PATCH v2 1/2] MIPS: Add device tree support to MIPS
Date:   Wed, 28 Jul 2010 15:47:20 -0500
Message-ID: <7A9214B0DEB2074FBCA688B30B04400D013FA46D@XMB-RCD-208.cisco.com>
In-Reply-To: <AANLkTi=74zoQziQTmAGo-cNtF9FAT77h+KZagsNEFjEf@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v2 1/2] MIPS: Add device tree support to MIPS
Thread-Index: Acsuir6im/gVuLm7Q42NhZphXDY2LgAChl2Q
From:   "Dezhong Diao (dediao)" <dediao@cisco.com>
To:     "Grant Likely" <grant.likely@secretlab.ca>,
        "David Daney" <ddaney@caviumnetworks.com>
Cc:     <devicetree-discuss@lists.ozlabs.org>, <linux-mips@linux-mips.org>,
        <ralf@linux-mips.org>,
        "David VomLehn (dvomlehn)" <dvomlehn@cisco.com>
X-OriginalArrivalTime: 28 Jul 2010 20:47:24.0560 (UTC) FILETIME=[152F8900:01CB2E96]
Return-Path: <dediao@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27511
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dediao@cisco.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------_=_NextPart_001_01CB2E96.148AEE28
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Grant,

I agree with your approach. Please go ahead to make changes and get the =
patches working with latest code in test tree. Or I am able to make =
changes in terms of your comments too.

It is best we can have MIPS OF support in 2.6.36, but I have you and =
Ralf decide it.


Thanks.


Dezhong =20

-----Original Message-----
From: glikely@secretlab.ca [mailto:glikely@secretlab.ca] On Behalf Of =
Grant Likely
Sent: Wednesday, July 28, 2010 12:26 PM
To: David Daney
Cc: Dezhong Diao (dediao); devicetree-discuss@lists.ozlabs.org; =
linux-mips@linux-mips.org; ralf@linux-mips.org; David VomLehn (dvomlehn)
Subject: Re: [PATCH v2 1/2] MIPS: Add device tree support to MIPS

On Wed, Jul 28, 2010 at 1:19 PM, David Daney <ddaney@caviumnetworks.com> =
wrote:
> On 07/28/2010 11:54 AM, Grant Likely wrote:
>>
>> Hi Dezhong,
>
> [...]
>>
>> Very nice clean patch, thanks! =A0How/when would you like to see MIPS =

>> OF support go into mainline?
>>
>
> I can't speak for the patch authors, but my preference would be to=20
> have MIPS OF support go in to 2.6.36 if possible.
>
> How? To me it doesn't matter. =A0I would let you and Ralf fight it =
out.

It would probably be best if I at least pick up the first patch into my =
test tree to give it a spin with the latest changes.  I'd be happy to =
take the 2nd too to avoid ordering issues.

Cheers,
g.

------_=_NextPart_001_01CB2E96.148AEE28
Content-Type: application/octet-stream;
	name="8KG6-DeviceTree-512MB.dts"
Content-Transfer-Encoding: base64
Content-Description: 8KG6-DeviceTree-512MB.dts
Content-Disposition: attachment;
	filename="8KG6-DeviceTree-512MB.dts"

L2R0cy12MS87CgovIHsKCW1vZGVsID0gIkV4cGxvcmVyIjsKCWNvbXBhdGlibGUgPSAiRXhwbG9y
ZXIiLCAiQ2FsbGlvcGUiOwoJY29weXJpZ2h0ID0gIkNvcHlyaWdodCAoYykgMjAwOCBDaXNjbyBT
eXN0ZW1zLCBJbmMuICBBbGwgUmlnaHRzIFJlc2VydmVkLiI7CgkjYWRkcmVzcy1jZWxscyA9IDww
eDE+OwoJI3NpemUtY2VsbHMgPSA8MHgxPjsKCgljcHVzIHsKCQluYW1lID0gImNwdXMiOwoJCSNh
ZGRyZXNzLWNlbGxzID0gPDB4MT47CgkJI3NpemUtY2VsbHMgPSA8MHgwPjsKCgkJMjRrQDAgewoJ
CQlkZXZpY2VfdHlwZSA9ICJjcHUiOwoJCQlyZWcgPSA8MHgwPjsKCQkJY2xvY2stZnJlcXVlbmN5
ID0gPDB4NWY1ZTEwMDA+OwoJCQl0aW1lYmFzZS1mcmVxdWVuY3kgPSA8MHgxZmNhMDU1PjsKCQkJ
aS1jYWNoZS1zaXplID0gPDB4ODAwMD47CgkJCWQtY2FjaGUtc2l6ZSA9IDwweDgwMDA+OwoJCX07
Cgl9OwoKCW1lbW9yaWVzIHsKCQluYW1lID0gIm1lbW9yaWVzIjsKCQlkZXZpY2VfdHlwZSA9ICJt
ZW1vcnkiOwoJCSNhZGRyZXNzLWNlbGxzID0gPDB4Mz47CgkJI3NpemUtY2VsbHMgPSA8MHgwPjsK
CgkJbWVtb3J5QDAgewoJCQltZW1vcnlfdHlwZSA9ICJsb3ciOwoJCQlyZWcgPSA8MHgxMDAwMDAw
MCAweDIwMDAwMDAwIDB4ZmMwMDAwMD47CgkJfTsKCgkJbWVtb3J5QDEgewoJCQltZW1vcnlfdHlw
ZSA9ICJNSVBTIHJlc2V0IHZlY3RvciI7CgkJCXJlZyA9IDwweDFmYzAwMDAwIDB4N2ZjZmZmZiAw
eDQwMDAwMD47CgkJfTsKCgkJbWVtb3J5QDIgewoJCQltZW1vcnlfdHlwZSA9ICJncC1zcmFtIjsK
CQkJcmVnID0gPDB4OTA0MDAwMCAweDkwNDAwMDAgMHgzMDAwMD47CgkJfTsKCgkJbWVtb3J5QDMg
ewoJCQltZW1vcnlfdHlwZSA9ICJoaWdoIjsKCQkJcmVnID0gPDB4MmZjMDAwMDAgMHgyZmMwMDAw
MCAweDQwMDAwMD47CgkJfTsKCgkJbWVtb3J5QDQgewoJCQltZW1vcnlfdHlwZSA9ICJoaWdoIjsK
CQkJcmVnID0gPDB4NjAwMDAwMDAgMHg2MDAwMDAwMCAweDEwMDAwMDAwPjsKCQl9OwoJfTsKCglv
cHRpb25zIHsKCQluYW1lID0gIm9wdGlvbnMiOwoJCW1vY2EtcG9wdWxhdGVkID0gInRydWUiOwoJ
CWhkLXBvcHVsYXRlZCA9ICJmYWxzZSI7CgkJaXItcHJvdG9jb2wgPSAiTU9UIjsKCQludm0tc2l6
ZSA9IDwweDEwMD47CgkJZnJvbnQtcGFuZWwtYnV0dG9uID0gImJ1dHRvbiI7CgkJcHVzaC1idXR0
b24tbWF0cml4ID0gIm1hdHJpeCI7CgkJdHVuaW5nLXJhbmdlID0gPDB4MzM0MjhmMDA+OwoJCXJl
YXItdXNiID0gInRydWUiOwoJCXZpZGVvLXN1cHBvcnQgPSAidHJ1ZSI7CgkJY2FibGUtY2FyZCA9
ICJmYWxzZSI7CgkJZXRoZXJuZXQgPSAidHJ1ZSI7CgkJbW9jYS1yYW5nZSA9ICJEMS1EOCI7CgkJ
dXNiLTIwLWh1YiA9ICJmYWxzZSI7CgkJc2Vjb25kLXFwc2stcnggPSAidHJ1ZSI7CgkJZnJvbnQt
cGFuZWwgPSAiZm91ciI7CgkJdHVuZXItaWMyLWNsb2NrLWZyZXEgPSA8MHgzMj47CgkJbWVtb3J5
LWVuY3J5cHRpb24tc2NoZW1lID0gImZpeGVkLWtleSI7Cgl9OwoKCWNob3NlbiB7CgkJbmFtZSA9
ICJjaG9zZW4iOwoJCWJvb3RhcmdzID0gInJvb3Q9L2Rldi9zZGEyIjsKCQlsaW51eCxwbGF0Zm9y
bSA9ICIxa2c2IjsKCX07Cn07Cg==

------_=_NextPart_001_01CB2E96.148AEE28--
