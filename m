Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3OB0jI11144
	for linux-mips-outgoing; Tue, 24 Apr 2001 04:00:45 -0700
Received: from mailgw2.netvision.net.il (mailgw2.netvision.net.il [194.90.1.9])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3OB0hM11141
	for <linux-mips@oss.sgi.com>; Tue, 24 Apr 2001 04:00:44 -0700
Received: from jungo.com ([194.90.113.98])
	by mailgw2.netvision.net.il (8.9.3/8.9.3) with ESMTP id OAA08073;
	Tue, 24 Apr 2001 14:02:09 +0300 (IDT)
Message-ID: <3AE55CA3.4050004@jungo.com>
Date: Tue, 24 Apr 2001 13:59:47 +0300
From: Michael Shmulevich <michaels@jungo.com>
Organization: Jungo LTD
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.17-21mdk i686; en-US; 0.8.1) Gecko/20010326
X-Accept-Language: en
MIME-Version: 1.0
To: Florian Lohoff <flo@rfc822.org>
CC: Ryan Murray <rmurray@debian.org>, linux-mips@oss.sgi.com
Subject: Re: ld.so-1.9.x for mips
References: <3AE44D0A.9080003@jungo.com> <20010423170302.E4623@bacchus.dhis.org> <3AE52A87.9050403@jungo.com> <20010424012409.A17800@cyberhqz.com> <3AE53D4E.2010803@jungo.com> <20010424124946.E6256@paradigm.rfc822.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Florian Lohoff wrote:

> On Tue, Apr 24, 2001 at 11:46:06AM +0300, Michael Shmulevich wrote:
> 
> 
>> The ld.so-1.9.11-15 that is on debian FTP site does not have any support 
>> for mips ELF. This is the reason why I was asking Florian, how did he 
>> manage to compile it for MIPS.
> 
> 
> Its the ld.so package from potato which itself does not contain
> the ld.so but "ldconfig". This was a misnaming for a while in debian.
> 
> Flo

 From this I conclude: no-one ever tried to check if ld.so works for 
mips ELF. Is it so?

Thanks.

Sincerely yours,
Michael Shmulevich
______________________________________
Software Developer
Jungo - R&D
email: michaels@jungo.com
web: http://www.jungo.com
Phone: 1-877-514-0537(USA)  +972-9-8859365(Worldwide) ext. 233
Fax:   1-877-514-0538(USA)  +972-9-8859366(Worldwide)
