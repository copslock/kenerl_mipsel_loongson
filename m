Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 Nov 2014 01:09:32 +0100 (CET)
Received: from resqmta-po-02v.sys.comcast.net ([96.114.154.161]:60021 "EHLO
        resqmta-po-02v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012949AbaKIAJbE-0kD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 9 Nov 2014 01:09:31 +0100
Received: from resomta-po-16v.sys.comcast.net ([96.114.154.240])
        by resqmta-po-02v.sys.comcast.net with comcast
        id DC971p0015BUCh401C9QLX; Sun, 09 Nov 2014 00:09:24 +0000
Received: from [192.168.1.13] ([69.251.152.165])
        by resomta-po-16v.sys.comcast.net with comcast
        id DC9N1p00G3aNLgd01C9Pnt; Sun, 09 Nov 2014 00:09:24 +0000
Message-ID: <545EB09C.40006@gentoo.org>
Date:   Sat, 08 Nov 2014 19:09:00 -0500
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: IP27: CONFIG_TRANSPARENT_HUGEPAGE triggers bus errors
References: <54560D3B.8060602@gentoo.org> <5457CF0A.7020303@gmail.com> <5458272A.7050309@gentoo.org> <54582A91.8040401@gmail.com> <20141105160945.GB13785@linux-mips.org> <545C9D4D.4090501@gentoo.org> <545D0FC4.7020205@gmail.com>
In-Reply-To: <545D0FC4.7020205@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1415491764;
        bh=iYtZwH3rRAfW8gtxQq+4N8CruVmUsJVDX66G7ZFLzGw=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=GbgaMVcTp6X1cFTQYXPBv1rWmebfN9zqkGGWrJmiVNj1uADErTQQ0kNi0xANFLgJt
         XjaVzEPht40EzESMueLf/k4kT6nKeCkA/dXbmK1NdvwbRfquPKYDYkX4Oqfgo55eXs
         80tI7I+jiQ6CdaSVi9sakzi3pBhqTVBq4nYn6rqJiqBv6jqNFHGSrWb2XThmGfnvL2
         D1ZuF28tpCxPxn+rYuCmy/UsCXgoJ/fR5xFI9CIpxOfx2pEw+HyCAVQiCgYQQGoNUB
         ozt+lRwWtD4pxY8DZMnIkRIjlCyOVSRJCoXQcyoyVr3LYz8LKjKDIpt16lLcI2RAec
         Vysu+TGb9rd0Q==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43932
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

On 11/07/2014 13:30, David Daney wrote:
> On 11/07/2014 02:22 AM, Joshua Kinard wrote:
> [...]
>>
>> So my guess is unless hugepages can happen in powers of 4,
> 
> Huge  pages are currently only supported on MIPS64 for this reason.
> 
> huge_page_mask_size = (normal_page_size/8 * normal_page_size) / 2;
> 
> If you take log2 of everything you get
> 
> huge_page_mask_bits = normal_page_bits - 3 + normal_page_bits - 1
>   = 2 * normal_page_bits - 4 (always even)
> 
> So all page sizes result in huge pages that meet the power of 4 criterion.

Well, looks like I'll have to bisect to hunt the problem down.  Obviously there
is something with transparent hugepages that the R10K-family dislikes.  Just a
question of "what?".  Seems like I'm the only one left with this kind of
equipment and interest to play with it :)

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
4096R/D25D95E3 2011-03-28

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
