Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jan 2015 03:54:28 +0100 (CET)
Received: from resqmta-ch2-02v.sys.comcast.net ([69.252.207.34]:33341 "EHLO
        resqmta-ch2-02v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011275AbbAUCy1Kv1l3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Jan 2015 03:54:27 +0100
Received: from resomta-ch2-07v.sys.comcast.net ([69.252.207.103])
        by resqmta-ch2-02v.sys.comcast.net with comcast
        id iSu81p0022EPM3101SuKqb; Wed, 21 Jan 2015 02:54:19 +0000
Received: from [192.168.1.13] ([73.212.71.42])
        by resomta-ch2-07v.sys.comcast.net with comcast
        id iSuJ1p00D0uk1nt01SuJli; Wed, 21 Jan 2015 02:54:19 +0000
Message-ID: <54BF14D2.70006@gentoo.org>
Date:   Tue, 20 Jan 2015 21:54:10 -0500
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Display CPU byteorder in /proc/cpuinfo
References: <54BCC827.3020806@gentoo.org> <54BEDF3C.6040105@gmail.com> <54BF12B9.8000507@gentoo.org>
In-Reply-To: <54BF12B9.8000507@gentoo.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1421808859;
        bh=ITHHb9cVUE7UsOEt1lRGz8mosYmZHgxOncxDgL1/ZSI=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=gfBIJfmWKZ+oLJkrwYrTxQFEKaJuGfCpxmXmbrfQ+oaOFncZ8PmiQJ7tOSxNr0eZA
         u5Ja3F5O481OgUge75TQVJXhdm3bOq1uo1yBJP4LCnyzRQCXUHd3R5znNjZo7TAYT4
         5xCArX/nWVhM0bunXKwQITrrqEekDlN/iY2KB7MU8XtpXpxkW30DPd6YiAFiUePzdC
         1mk5sfqgV6+wwSZpIqr+zwskoHKClLrJ/btR9Qt2KeKppvmzegM/w4kST0WIYqO5xz
         4RH8Xa9Va9UH1vR60PmzDkTY9IdZf7SoL2eW4TQa7acbH+BBCt8L8JHTKalz0qctgb
         kUQzsrWSdh9MA==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45389
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On 01/20/2015 21:45, Joshua Kinard wrote:
> On 01/20/2015 18:05, David Daney wrote:
>> On 01/19/2015 01:02 AM, Joshua Kinard wrote:
>>> From: Joshua Kinard <kumba@gentoo.org>
>>>
>>> This is a small patch to display the CPU byteorder that the kernel was compiled
>>> with in /proc/cpuinfo.
>>
>> What would use this?  Or in other words, why is this needed?
> 
> It was a patch I started including years ago in Gentoo's mips-sources, and just
> never thought much about.  I know it was submitted several times in the past,
> but I can't recall what, if any objection was ever made.  No harm in sending it
> in again...

Clarification, submitted several times in the past by others.  I think I sent
it in once prior, but never got review or feedback.


>> Userspace C code doesn't need this as it has its own standard ways of
>> determining endianness.
>>
>> If you need to know as a user you can do:
>>
>>    readelf -h /bin/sh | grep Data | cut -d, -f2
> 
> This would only tell you the endianness of the userland binary, not of the
> kernel.  While they should be one and the same (otherwise, you're not going to
> get very far anyways), they are, technically, distinctly different properties.
> 
> --J
> 
