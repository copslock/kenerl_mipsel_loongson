Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jun 2018 11:40:15 +0200 (CEST)
Received: from mga02.intel.com ([134.134.136.20]:32959 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994552AbeFRJkBiso2- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 18 Jun 2018 11:40:01 +0200
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2018 02:39:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,238,1526367600"; 
   d="scan'208";a="58488512"
Received: from songjunw-mobl1.ger.corp.intel.com (HELO [10.226.39.15]) ([10.226.39.15])
  by fmsmga002.fm.intel.com with ESMTP; 18 Jun 2018 02:39:54 -0700
Subject: Re: [PATCH 4/7] tty: serial: lantiq: Always use readl()/writel()
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     hua.ma@linux.intel.com, yixin.zhu@linux.intel.com,
        chuanhua.lei@intel.com,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        qi-ming.wu@intel.com, linux-clk <linux-clk@vger.kernel.org>,
        linux-serial@vger.kernel.org, DTML <devicetree@vger.kernel.org>,
        James Hogan <jhogan@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ralf Baechle <ralf@linux-mips.org>
References: <20180612054034.4969-1-songjun.wu@linux.intel.com>
 <20180612054034.4969-5-songjun.wu@linux.intel.com>
 <CAK8P3a0K6qezHLcjkeq0zd+iQJQc_qbT2JhtZGrCNRT495sUvQ@mail.gmail.com>
From:   "Wu, Songjun" <songjun.wu@linux.intel.com>
Message-ID: <f992c920-7e57-8099-b13c-f3651c0d1594@linux.intel.com>
Date:   Mon, 18 Jun 2018 17:39:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0K6qezHLcjkeq0zd+iQJQc_qbT2JhtZGrCNRT495sUvQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Return-Path: <songjun.wu@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64350
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: songjun.wu@linux.intel.com
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



On 6/14/2018 6:07 PM, Arnd Bergmann wrote:
> On Tue, Jun 12, 2018 at 7:40 AM, Songjun Wu <songjun.wu@linux.intel.com> wrote:
>> Previous implementation uses platform-dependent functions
>> ltq_w32()/ltq_r32() to access registers. Those functions are not
>> available for other SoC which uses the same IP.
>> Change to OS provided readl()/writel() and readb()/writeb(), so
>> that different SoCs can use the same driver.
>>
>> Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
> Are there any big-endian machines using this driver? The original definition
> of ltq_r32() uses non-byteswapping __raw_readl() etc, which suggests
> that the registers might be wired up in a way that matches the CPU
> endianess (this is usally a bad idea in hardware design, but nothing
> we can influence in the OS).
>
> When you change it to readl(), that will breaks all machines that rely
> on the old behavior on big-endian kernels.
>
>        Arnd
It will not break existing big-endian SoC as SWAP_IO_SPACE is disabled.

Disable SWAP_IO_SPACE will not impact ltq_r32 as it uses non-byte 
swapping __raw_readl() and it makes readl work in big-endian kernel too.

The old Lantiq platform enable SWAP_IO_SPACE to support PCI as it's a 
little-endian bus plus PCI TX/RX swap enable impacted both data and 
control path.
Alternatively PCI device driver has to do endian swap, It is better to 
let PCI device driver to do endian swap instead because SWAP_IO_SPACE is 
global wide macro.
Once we set it, other peripheral such as USB has to change its register 
access as well
