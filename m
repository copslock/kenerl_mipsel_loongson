Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Mar 2005 17:21:50 +0000 (GMT)
Received: from 64-30-195-78.dsl.linkline.com ([IPv6:::ffff:64.30.195.78]:55013
	"EHLO jg555.com") by linux-mips.org with ESMTP id <S8225319AbVCGRVT>;
	Mon, 7 Mar 2005 17:21:19 +0000
Received: from [172.16.0.150] (w2rz8l4s02.jg555.com [::ffff:172.16.0.150])
  (AUTH: PLAIN root, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by jg555.com with esmtp; Mon, 07 Mar 2005 09:21:17 -0800
  id 00008471.422C8D8D.00005233
Message-ID: <422C8D6A.6060904@jg555.com>
Date:	Mon, 07 Mar 2005 09:20:42 -0800
From:	Jim Gifford <maillist@jg555.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Linux MIPS List <linux-mips@linux-mips.org>
Subject: IPTables 1.3.x fails on RaQ2
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <maillist@jg555.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7390
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maillist@jg555.com
Precedence: bulk
X-list: linux-mips

I've been trying to figure out why the current iptables fails on the 
2.6.9 and 2.6.11 MIPS builds. It seems that a file 
cpu-features-overrides.h is missing for the Cobalt builds. Are their 
plans for one, or is there a patch out there so we can get it added. 
Here is the error message on the IPTables build, I still don't 
understand why they are checking for that myself.

# ./iptables install
        Verifying iptables-1.3.1.tar.bz2
                Downloading iptables-1.3.1.tar.bz2
                Creating Local SHA1 file for iptables-1.3.1.tar.bz2
                Installing iptables-1.3.1
                        Unpacking iptables-1.3.1.tar.bz2
Making dependencies: please wait...
Something wrong... deleting dependencies.
make: *** [cpu-feature-overrides.h] Error 1
                -----Error at Build has occured-----
Exiting

-- 
----
Jim Gifford
maillist@jg555.com
