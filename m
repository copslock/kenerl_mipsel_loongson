Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Jun 2016 13:39:28 +0200 (CEST)
Received: from resqmta-po-06v.sys.comcast.net ([96.114.154.165]:45131 "EHLO
        resqmta-po-06v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27025203AbcFXLj1HjMdG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Jun 2016 13:39:27 +0200
Received: from resomta-po-19v.sys.comcast.net ([96.114.154.243])
        by resqmta-po-06v.sys.comcast.net with SMTP
        id GPSBbWf9cBNj9GPSBbVI0e; Fri, 24 Jun 2016 11:39:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1466768359;
        bh=gR7Lf3G8+LRi8Kp0T4rexfpJSZNEQf2R8HGYEDE76eU=;
        h=Received:Received:Subject:To:From:Message-ID:Date:MIME-Version:
         Content-Type;
        b=s4YsKdoeLK2vjDIT/xqG+fluVzpeXKwFGzYtpbAK1OxAsOow5MVpDvaQEe6JeKcD0
         Z98pcYDZ8j4aTdNQpm3+qDRjfQJDcXndxloyUo980rhiU0uEMebxOal9HdlcuO26iw
         +4aujvN4GHQfu4IURBKYzUM6q4ub9nhjfTn34izyNWQ0/UjRERFGAo3z8ZI5RPRrp7
         ux/7/DzjvM0CmmAgY23WcYd/P6AZOf/3VLQQpYc8rmyiwZxNCJ45oCWgOg40ffwlIr
         fu/C/gUeOANfe9HbotyADmr0zhTttphUVdJe8Kmi89F/q8Wv5VzN6TjcKNza3XOAkr
         nCUaY6eiqWEXw==
Received: from [192.168.1.13] ([76.106.83.43])
        by resomta-po-19v.sys.comcast.net with comcast
        id AbfH1t00N0w5D3801bfJ5G; Fri, 24 Jun 2016 11:39:19 +0000
Subject: Re: THP broken on OCTEON?
To:     Aaro Koskinen <aaro.koskinen@nokia.com>,
        David Daney <ddaney.cavm@gmail.com>
References: <20160523151346.GA23204@ak-desktop.emea.nsn-net.net>
 <576B0B91.2020608@gmail.com>
 <20160623120757.GQ3012@ak-desktop.emea.nsn-net.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        "Kirill A. Shutemov" <kirill@shutemov.name>
From:   Joshua Kinard <kumba@gentoo.org>
Message-ID: <0b98da9a-8f1e-5ef1-37d7-253adfec2e10@gentoo.org>
Date:   Fri, 24 Jun 2016 07:38:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <20160623120757.GQ3012@ak-desktop.emea.nsn-net.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54157
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

On 06/23/2016 08:08, Aaro Koskinen wrote:
> Hi,
> 
> On Wed, Jun 22, 2016 at 03:05:05PM -0700, David Daney wrote:
>> This is caused by a config bug.
>>
>> For THP to work you must have both:
>>
>> CONFIG_TRANSPARENT_HUGEPAGE=y
>> and
>> CONFIG_HUGETLBFS=y
> 
> Oh... I guess this is with MIPS only?
> 
>> Please try testing with both of those set as well as applying:
>>
>> https://www.linux-mips.org/archives/linux-mips/2016-06/msg00397.html
> 
> Works! Now the system is stable. EBH5600 built dozen of different packages
> without any issues and THP being used:
> 
> root@localhost:~$ grep thp /proc/vmstat 
> thp_fault_alloc 2271
> thp_fault_fallback 0
> thp_collapse_alloc 2049
> thp_collapse_alloc_failed 0
> thp_split_page 0
> thp_split_page_failed 0
> thp_deferred_split_page 3996
> thp_split_pmd 186
> thp_zero_page_alloc 0
> thp_zero_page_alloc_failed 0
> 
> Thanks a lot,
> 
> A. 
> 

The case on the IP27 is still broke, it seems, with this patch.  Actually
triggers a HUB error interrupt now instead of a bus error, so I guess that's an
improvement in a sense.  Though, I am still re-working the entire IP27 code
base, so I'll add this to the list of things to try and hunt down.  I'll have
to add some code to read HUB's cause register and extract what error bit got
flipped on.

Have not tried the IP30/Octane case yet.

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
