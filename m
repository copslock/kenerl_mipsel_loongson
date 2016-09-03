Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Sep 2016 12:29:04 +0200 (CEST)
Received: from mga07.intel.com ([134.134.136.100]:37736 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992111AbcICK25Hnz0F (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 3 Sep 2016 12:28:57 +0200
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP; 03 Sep 2016 03:28:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.30,275,1470726000"; 
   d="gz'50?scan'50,208,50";a="4699475"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by orsmga004.jf.intel.com with ESMTP; 03 Sep 2016 03:28:50 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <fengguang.wu@intel.com>)
        id 1bg8CO-000G9X-7a; Sat, 03 Sep 2016 18:29:20 +0800
Date:   Sat, 3 Sep 2016 18:27:43 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     kbuild-all@01.org, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 05/12] MIPS: Malta: Use all available DDR by default
Message-ID: <201609031837.uZSsTlt8%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
In-Reply-To: <20160902154859.24269-6-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Return-Path: <fengguang.wu@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55030
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lkp@intel.com
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


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Paul,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.8-rc4 next-20160825]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Paul-Burton/Partial-MIPS-Malta-DT-conversion/20160903-000153
config: mips-malta_kvm_defconfig (attached as .config)
compiler: mipsel-linux-gnu-gcc (Debian 5.4.0-6) 5.4.0 20160609
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=mips 

Note: the linux-review/Paul-Burton/Partial-MIPS-Malta-DT-conversion/20160903-000153 HEAD c8f10f160bc7b6a6b2cd9162137dd9774b018092 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   arch/mips/mti-malta/malta-dtshim.c: In function 'malta_scon':
>> arch/mips/mti-malta/malta-dtshim.c:40:13: error: 'MIPS_REVISION_SCONID' undeclared (first use in this function)
     int scon = MIPS_REVISION_SCONID;
                ^
   arch/mips/mti-malta/malta-dtshim.c:40:13: note: each undeclared identifier is reported only once for each function it appears in
>> arch/mips/mti-malta/malta-dtshim.c:42:14: error: 'MIPS_REVISION_SCON_OTHER' undeclared (first use in this function)
     if (scon != MIPS_REVISION_SCON_OTHER)
                 ^
>> arch/mips/mti-malta/malta-dtshim.c:45:10: error: 'MIPS_REVISION_CORID' undeclared (first use in this function)
     switch (MIPS_REVISION_CORID) {
             ^
>> arch/mips/mti-malta/malta-dtshim.c:46:7: error: 'MIPS_REVISION_CORID_QED_RM5261' undeclared (first use in this function)
     case MIPS_REVISION_CORID_QED_RM5261:
          ^
>> arch/mips/mti-malta/malta-dtshim.c:47:7: error: 'MIPS_REVISION_CORID_CORE_LV' undeclared (first use in this function)
     case MIPS_REVISION_CORID_CORE_LV:
          ^
>> arch/mips/mti-malta/malta-dtshim.c:48:7: error: 'MIPS_REVISION_CORID_CORE_FPGA' undeclared (first use in this function)
     case MIPS_REVISION_CORID_CORE_FPGA:
          ^
>> arch/mips/mti-malta/malta-dtshim.c:49:7: error: 'MIPS_REVISION_CORID_CORE_FPGAR2' undeclared (first use in this function)
     case MIPS_REVISION_CORID_CORE_FPGAR2:
          ^
>> arch/mips/mti-malta/malta-dtshim.c:50:10: error: 'MIPS_REVISION_SCON_GT64120' undeclared (first use in this function)
      return MIPS_REVISION_SCON_GT64120;
             ^
>> arch/mips/mti-malta/malta-dtshim.c:52:7: error: 'MIPS_REVISION_CORID_CORE_EMUL_BON' undeclared (first use in this function)
     case MIPS_REVISION_CORID_CORE_EMUL_BON:
          ^
>> arch/mips/mti-malta/malta-dtshim.c:53:7: error: 'MIPS_REVISION_CORID_BONITO64' undeclared (first use in this function)
     case MIPS_REVISION_CORID_BONITO64:
          ^
>> arch/mips/mti-malta/malta-dtshim.c:54:7: error: 'MIPS_REVISION_CORID_CORE_20K' undeclared (first use in this function)
     case MIPS_REVISION_CORID_CORE_20K:
          ^
>> arch/mips/mti-malta/malta-dtshim.c:55:10: error: 'MIPS_REVISION_SCON_BONITO' undeclared (first use in this function)
      return MIPS_REVISION_SCON_BONITO;
             ^
>> arch/mips/mti-malta/malta-dtshim.c:57:7: error: 'MIPS_REVISION_CORID_CORE_MSC' undeclared (first use in this function)
     case MIPS_REVISION_CORID_CORE_MSC:
          ^
>> arch/mips/mti-malta/malta-dtshim.c:58:7: error: 'MIPS_REVISION_CORID_CORE_FPGA2' undeclared (first use in this function)
     case MIPS_REVISION_CORID_CORE_FPGA2:
          ^
>> arch/mips/mti-malta/malta-dtshim.c:59:7: error: 'MIPS_REVISION_CORID_CORE_24K' undeclared (first use in this function)
     case MIPS_REVISION_CORID_CORE_24K:
          ^
>> arch/mips/mti-malta/malta-dtshim.c:60:10: error: 'MIPS_REVISION_SCON_SOCIT' undeclared (first use in this function)
      return MIPS_REVISION_SCON_SOCIT;
             ^
>> arch/mips/mti-malta/malta-dtshim.c:62:7: error: 'MIPS_REVISION_CORID_CORE_FPGA3' undeclared (first use in this function)
     case MIPS_REVISION_CORID_CORE_FPGA3:
          ^
>> arch/mips/mti-malta/malta-dtshim.c:63:7: error: 'MIPS_REVISION_CORID_CORE_FPGA4' undeclared (first use in this function)
     case MIPS_REVISION_CORID_CORE_FPGA4:
          ^
>> arch/mips/mti-malta/malta-dtshim.c:64:7: error: 'MIPS_REVISION_CORID_CORE_FPGA5' undeclared (first use in this function)
     case MIPS_REVISION_CORID_CORE_FPGA5:
          ^
>> arch/mips/mti-malta/malta-dtshim.c:65:7: error: 'MIPS_REVISION_CORID_CORE_EMUL_MSC' undeclared (first use in this function)
     case MIPS_REVISION_CORID_CORE_EMUL_MSC:
          ^

vim +/MIPS_REVISION_SCONID +40 arch/mips/mti-malta/malta-dtshim.c

    34	};
    35	
    36	#define MAX_MEM_ARRAY_ENTRIES 2
    37	
    38	static __init int malta_scon(void)
    39	{
  > 40		int scon = MIPS_REVISION_SCONID;
    41	
  > 42		if (scon != MIPS_REVISION_SCON_OTHER)
    43			return scon;
    44	
  > 45		switch (MIPS_REVISION_CORID) {
  > 46		case MIPS_REVISION_CORID_QED_RM5261:
  > 47		case MIPS_REVISION_CORID_CORE_LV:
  > 48		case MIPS_REVISION_CORID_CORE_FPGA:
  > 49		case MIPS_REVISION_CORID_CORE_FPGAR2:
  > 50			return MIPS_REVISION_SCON_GT64120;
    51	
  > 52		case MIPS_REVISION_CORID_CORE_EMUL_BON:
  > 53		case MIPS_REVISION_CORID_BONITO64:
  > 54		case MIPS_REVISION_CORID_CORE_20K:
  > 55			return MIPS_REVISION_SCON_BONITO;
    56	
  > 57		case MIPS_REVISION_CORID_CORE_MSC:
  > 58		case MIPS_REVISION_CORID_CORE_FPGA2:
  > 59		case MIPS_REVISION_CORID_CORE_24K:
  > 60			return MIPS_REVISION_SCON_SOCIT;
    61	
  > 62		case MIPS_REVISION_CORID_CORE_FPGA3:
  > 63		case MIPS_REVISION_CORID_CORE_FPGA4:
  > 64		case MIPS_REVISION_CORID_CORE_FPGA5:
  > 65		case MIPS_REVISION_CORID_CORE_EMUL_MSC:
    66		default:
  > 67			return MIPS_REVISION_SCON_ROCIT;
    68		}
    69	}
    70	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--HcAYCG3uE/tztfnV
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--HcAYCG3uE/tztfnV--
