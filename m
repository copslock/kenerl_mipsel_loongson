Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 May 2003 20:28:03 +0100 (BST)
Received: from smtp-out.comcast.net ([IPv6:::ffff:24.153.64.116]:59640 "EHLO
	smtp-out.comcast.net") by linux-mips.org with ESMTP
	id <S8225290AbTEJT2A>; Sat, 10 May 2003 20:28:00 +0100
Received: from gentoo.org
 (pcp02545003pcs.waldrf01.md.comcast.net [68.48.92.102])
 by mtaout01.icomcast.net
 (iPlanet Messaging Server 5.2 HotFix 1.12 (built Feb 13 2003))
 with ESMTP id <0HEO00MCIREH0Z@mtaout01.icomcast.net> for
 linux-mips@linux-mips.org; Sat, 10 May 2003 15:27:53 -0400 (EDT)
Date: Sat, 10 May 2003 15:30:46 -0400
From: Kumba <kumba@gentoo.org>
Subject: Re: OpenSSL/Binutils Issues
To: linux-mips@linux-mips.org
Reply-to: kumba12345@comcast.net
Message-id: <3EBD5366.70705@gentoo.org>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_LXLHwkY3zK0CyBluimbQ7g)"
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.3)
 Gecko/20030312
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2342
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

--Boundary_(ID_LXLHwkY3zK0CyBluimbQ7g)
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT


It's attached in gzip format, as there was quite a bit of a return. 
Many assertion fails and invalid symbol indexes.

Let me know if you need anything more.

--Kumba


Thiemo Wrote:
>Kumba wrote:
[snip]
>> 	Which builds fine.  Then the error hits when attempting to execute 
>> 	the "conftest" executable:
>> 
>> 		./conftest: error while loading shared libraries:
>> 		usr/lib/libcrypto.so.0.9.6: unexpected reloc type 0x68
>
> This libcrypto seems to be broken. 0x68 is not a valid MIPS reloc type
> at all, and a shared lib should use only R_MIPS_32 (type 2) relocations
> anyway.

>> 	Has anyone seen anything like this?  My base mips install on my SGI 
>> Indigo2 is built using binutils-2.13.90.0.16, which builds everything 
>> fine, just doesn't cooperate well with -mips3 or higher options.  I'm 
>> not sure if this is mips-specific, or if I need to bother the OpenSSL 
>> team about it.
>
> It is probably a binutils issue. Can you send the output of
> objdump -R usr/lib/libcrypto.so.0.9.6 |grep R_MIPS |grep -v \(R_MIPS_32\|R_MIPS_NONE\)
> 
> 
> Thiemo









--Boundary_(ID_LXLHwkY3zK0CyBluimbQ7g)
Content-type: application/x-gzip; name=crypto-grep-mips.txt.gz
Content-transfer-encoding: base64
Content-disposition: inline; filename=crypto-grep-mips.txt.gz

H4sICIBRvT4CA2NyeXB0by1ncmVwLW1pcHMudHh0AO2dTWtbVxCG94X8hwvZJAtf3/N55/Uq
lKbQRdKSLusSJEtJVWRJSHaIIT++aut9Qs2UZzELG8mLlznS9TOjo/twfjvu93evFruPy8Vu
NSw3u/u7zfb0+/Nhv/xzdX97GC7eDZenw+JmfXl/Ol5uN8u/f26OD4e7/Xjaj9OosQ9fPh7X
h+Hd+zc//fLr45OLT8P1i3//8r7k6y+PD9/+/Pb19ctn333/4w9XXw9+MR7X23H1sHt5NZwf
7W8Wd5v9bpiGPxanYbP7tNhuVsPp4Xa5356frtafh+kx+vxryGMqo6ZzVOpDnqacUu7D4nRa
H/+J+bDYbIf19kPJF7ebw2m8uUpVLQIiIAIiIAIiIAIiIAIiIAIiIAIiIAIiIAIiIAIiIAIi
IAIiIAIiIAIiIAIiIAIiIAIiIAIiIAIiIAIiIAIiIAIigB7wX2/GLnNrX78f+wnp/X+42/sJ
5c2uizf24oUur0+e701P7MVndnnF9b2p7MW7ErOzidlndnls5HY2cueJXR6b2XP25MJc2Iuv
rotv7MWzmT2zmT2zmT2zmW1sZlvy5IKxx2RjM9vYc7axoW9s6Jvr1oaxmW1sZovNbLHnbLGh
Lzb0xYa+2NAXG/piT/pidw2hu4ZNE7s8z0nfpuyaXtgvbWWX19jldXZ5M7s8Y5cnTy4kNnJT
YpeX2eWxoZ/Y0E9s6KfuygU2sxOb2cmV2ZnN7MxmdmYzOxfXS6e6prOJmV2JmdnEzGxiZvbO
RGEjt7CRW9jILewxubDH5MKGfmHvjRR21yjsrlHYXaN63uBtlQ39yoZ+ZUO/sqFf2dCvrpN+
ZTO7spld2cxu7Em/saHf2NBvbOg3NvQbG/psE9Mau2uwVU5jq5zW2V2D7YJad731xVXlNLbK
aZ3NbLYLamwX1NguqLFdUGO7oMZ2QW1mT/psmdRmdtdg26g2u27vzLNrOpvZbBfU2C6oGZvZ
5jpns11QM9dbX9gqp7FVTjP2nM12QY3tghrbBTW2C2psF9TYLqixXVBju6DGdkGN7YIa2wU1
tgsqtgsqVxdUU2YvvrguvrIX39jldXZ5M7s8Y5fn6RWJ7YKK7YKK7YKK7YKK7YKK7YIqsaHP
lknFlkmV2IM620YV20YV20ZVZneNzO4abB9Wmd012EKt2EKt2EKtiqcaJbYPK7YPK7YPK7YP
K7YPq9Jd//HYzP4WnfUJ6WzkutqoYtuoYtuoqq476myZVGyZVJU9JrNtVFVX5FbXDXG2C6rm
+h0kW+UUW+UUW+UUW+UUW+WU66GaYpuYaq7IZYuUYouUYh+qqc5mdq+uVzYbuWwTU2wTU2wT
U2wTU7PrzgRbpBRbpBRbpBRbpBRbpBT7WE+xj/UUW+UUW+WUuUKfbWKKfaynzHU7mn0qp75F
5XxCOhu5bBNTbBNTbBNTckUuW6QUW6QUW6SUXPdG5IpctsYotsYotsYotMZYJ7TGeC7P8SvE
c3p2TS/sl7ayy2vs8jq7vNn1yjb24tnITWzkojXGc3mZXR4b+okN/cSGfmJDH60xnstjd43E
7hqZ3TUyu2tkdtfI7K6R2V0js7tGZneNzO4amd01sjw/aBU29Asb+sV1e6ewmV3YzC5sZhc2
swub2YXN7OLK7MpmdnXdUa/sObuymV3ZzK7N9dJhI7eykVvZyK2uyG1s5Db2mNxcx2RvD/Iv
CfnI4ILZAAA=

--Boundary_(ID_LXLHwkY3zK0CyBluimbQ7g)--
