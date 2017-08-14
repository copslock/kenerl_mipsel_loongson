Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Aug 2017 01:48:52 +0200 (CEST)
Received: from resqmta-ch2-07v.sys.comcast.net ([IPv6:2001:558:fe21:29:69:252:207:39]:50790
        "EHLO resqmta-ch2-07v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993934AbdHNXso3PxSI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Aug 2017 01:48:44 +0200
Received: from resomta-ch2-16v.sys.comcast.net ([69.252.207.112])
        by resqmta-ch2-07v.sys.comcast.net with ESMTP
        id hP63dnjqvrUTyhP63doifH; Mon, 14 Aug 2017 23:48:35 +0000
Received: from [192.168.1.13] ([73.201.189.102])
        by resomta-ch2-16v.sys.comcast.net with SMTP
        id hP61dimeTeaimhP62dv0eX; Mon, 14 Aug 2017 23:48:35 +0000
Subject: Re: [PATCH v2 1/8] MIPS: Introduce CPU_ISA_GE_* Kconfig entries
To:     "Steven J. Hill" <Steven.Hill@cavium.com>,
        Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>
References: <20170814181819.7376-1-paul.burton@imgtec.com>
 <20170814181819.7376-2-paul.burton@imgtec.com>
 <86ddc490-dabd-66b5-ebd7-aed6535d3966@cavium.com>
From:   Joshua Kinard <kumba@gentoo.org>
Message-ID: <9b96db98-3c79-e51a-8fee-2caa98f80422@gentoo.org>
Date:   Mon, 14 Aug 2017 19:48:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <86ddc490-dabd-66b5-ebd7-aed6535d3966@cavium.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfKpbswSLm2DRJtVeQr0rtFayPYrOmgDosXbdKZvwFEo1GNIOsMEOhG1207Lygt1rXSPJ+im/m2E4Qhvey1ov6Tvn28nEpz9IzBmmd/FTXwpewbhr+QZL
 xOSHV7aKORu+eFuK1WesMnhym3GWJUeCiUnr6mZx5nP7ycry3JrfANwLMKVk4YLsgjXlZXNthUgTB/c2eGhaN5sJ6v3eaMv5Scp1eYcpuaFZLVXyQ+GzOzC6
 AQybbI3ZgnVL0hFCx6EaDAYzeMJ4S3zYefG2dB2RNjerpJHz6fbyI1pEptJpjluMkiGoHInUbFXMlVZREs/yPQ==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59581
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

On 08/14/2017 14:56, Steven J. Hill wrote:
> On 08/14/2017 01:18 PM, Paul Burton wrote:
> 
> [...]
>>
>> With the new Kconfig entries introduced by this patch this can be
>> simplified to:
>>
>>   default y if CPU_ISA_GE_R1
>>
> The idea for the patch is solid. Can we not just use CPU_ISA_R1,
> and so on? GE immediately makes me think "Graphics Engine" and
> there are the GE7 ASICs from old SGI hardware. Maybe it's just
> me and it doesn't confuse anyone else.

GE7 ASICs?  Which SGI Machines had those?  Or do you refer to the "Graphics
Backend" (gbefb) framebuffer in SGI O2s?

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
6144R/F5C6C943 2015-04-27
177C 1972 1FB8 F254 BAD0 3E72 5C63 F4E3 F5C6 C943

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
