Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Jan 2005 17:46:58 +0000 (GMT)
Received: from support.romat.com ([IPv6:::ffff:212.143.245.3]:48142 "EHLO
	mail.romat.com") by linux-mips.org with ESMTP id <S8225226AbVABRqw>;
	Sun, 2 Jan 2005 17:46:52 +0000
Received: from localhost (localhost.lan [127.0.0.1])
	by mail.romat.com (Postfix) with ESMTP id 92A93EB30D;
	Sun,  2 Jan 2005 19:46:34 +0200 (IST)
Received: from mail.romat.com ([127.0.0.1])
 by localhost (mail.romat.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 41209-09; Sun,  2 Jan 2005 19:46:31 +0200 (IST)
Received: from [192.168.1.199] (linux.lan [192.168.1.199])
	by mail.romat.com (Postfix) with ESMTP id E52AEEB2B6;
	Sun,  2 Jan 2005 19:46:30 +0200 (IST)
Message-ID: <41D83376.9040403@romat.com>
Date: Sun, 02 Jan 2005 19:46:30 +0200
From: Gilad Rom <gilad@romat.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Stephen P. Becker" <geoman@gentoo.org>
Cc: Scott Parker <whtghst1@direcway.com>,
	Mudeem Iqbal <mudeem@Quartics.com>,
	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: cross compiling gcc for mips
References: <1B701004057AF74FAFF851560087B161064698@1aurora.enabtech> <41D8274F.7070203@direcway.com> <41D828E9.2020109@gentoo.org>
In-Reply-To: <41D828E9.2020109@gentoo.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: by amavisd-new at romat.com
Return-Path: <gilad@romat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6798
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gilad@romat.com
Precedence: bulk
X-list: linux-mips

Just incase you haven't tried it yet, I'd recommend
crosstool (http://kegel.com/crosstool/) a very nice
set of scripts to automate the toolchain building
process. Also, uClibc has a very nice toolchain
build script at http://www.uclibc.org/toolchains.html
(if you are aiming for an embedded target).

Gilad.

Stephen P. Becker wrote:
> Scott Parker wrote:
> 
>> How did you configure GCC?
>>
>> Mudeem Iqbal wrote:
>>
>>> Hi,
>>>
>>> I am building a toolchain for mips platform. I am using
>>>
>>> binutils-2.15
>>> gcc-3.4.3
>>> glibc-2.3.3
>>> linux-2.6.9    (from linux-mips.org)
>>>
> 
> Try using 2.4 headers instead.  I haven't had much success using 2.6 
> headers to build a mips (cross)toolchain.
> 
> Steve
> 
> 
> 
