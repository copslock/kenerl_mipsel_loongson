Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Aug 2018 09:21:59 +0200 (CEST)
Received: from mga14.intel.com ([192.55.52.115]:48731 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992241AbeHCHVyFWbO2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 3 Aug 2018 09:21:54 +0200
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Aug 2018 00:21:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,437,1526367600"; 
   d="scan'208";a="59391313"
Received: from songjunw-mobl1.ger.corp.intel.com (HELO [10.226.39.42]) ([10.226.39.42])
  by fmsmga007.fm.intel.com with ESMTP; 03 Aug 2018 00:21:46 -0700
Subject: Re: [PATCH v2 15/18] serial: intel: Support more platform
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     hua.ma@linux.intel.com, yixin.zhu@linux.intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
References: <20180803030237.3366-1-songjun.wu@linux.intel.com>
 <20180803030237.3366-16-songjun.wu@linux.intel.com>
 <20180803055709.GB32226@kroah.com>
From:   "Wu, Songjun" <songjun.wu@linux.intel.com>
Message-ID: <2bd3f808-ed93-ac2c-a802-957a88129e67@linux.intel.com>
Date:   Fri, 3 Aug 2018 15:21:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180803055709.GB32226@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Return-Path: <songjun.wu@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65383
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



On 8/3/2018 1:57 PM, Greg Kroah-Hartman wrote:
> On Fri, Aug 03, 2018 at 11:02:34AM +0800, Songjun Wu wrote:
>> Support more platform.
>>
>> Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
>> ---
> Your changelog text makes no sense, sorry.
Thanks for your comment.
I will describe it more clearly.
