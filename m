Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Aug 2004 21:12:29 +0100 (BST)
Received: from messageii.ucentric.com ([IPv6:::ffff:216.140.202.124]:29195
	"EHLO messageii.ucentric.com") by linux-mips.org with ESMTP
	id <S8225238AbUHXUMZ>; Tue, 24 Aug 2004 21:12:25 +0100
Received: from [192.168.11.23] by messageii.ucentric.com with HTTP; Tue, 24 Aug 2004 16:12:16 -0400
Date: Tue, 24 Aug 2004 16:12:16 -0400
Message-ID: <40B0AFD9000003B6@messageii.ucentric.com>
In-Reply-To: <20040824175811.GA20768@lucon.org>
From: "Brad Kemp" <bkemp@ucentric.com>
Subject: Re: broadcom mips
To: "H. J. Lu" <hjl@lucon.org>, "Brian Burrows" <brianb@p3mc.net>
Cc: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-Path: <bkemp@ucentric.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5733
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bkemp@ucentric.com
Precedence: bulk
X-list: linux-mips

>H.J.
>On Mon, Aug 23, 2004 at 09:31:11PM -0700, Brian Burrows wrote:
>> Hello,
>> 
>> I am new to linux, however i have been a windows programmer for years.
>Well 
>> , i would like to compile a simple relocatable elf for a broadcom cpu
,
>mips 
>> r3000 . I have searched and searched and I am still not capable of making
>my 
>> own cross compiler. 
>> Do you know of any pre made ones? gcc?
>> Any details you can / will give me are very appreciated
>> 
>> cheers
>> brian
>
If these don't work for you
http://www.linux-mips.org/toolchain.html
You'll have to build it yourself
http://kegel.com/crosstool/
Brad
