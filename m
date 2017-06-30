Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jun 2017 03:04:54 +0200 (CEST)
Received: from mga02.intel.com ([134.134.136.20]:45927 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993992AbdF3BEqNy0yo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 30 Jun 2017 03:04:46 +0200
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2017 18:04:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.40,283,1496127600"; 
   d="gz'50?scan'50,208,50";a="119168121"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by orsmga005.jf.intel.com with ESMTP; 29 Jun 2017 18:04:41 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <fengguang.wu@intel.com>)
        id 1dQkPw-000SI9-3Q; Fri, 30 Jun 2017 09:08:16 +0800
Date:   Fri, 30 Jun 2017 09:03:54 +0800
From:   kbuild test robot <fengguang.wu@intel.com>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     kbuild-all@01.org, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [mips-sjhill:mips-for-linux-next 46/72]
 kernel/locking/qspinlock.c:549:4: error: implicit declaration of function
 'prefetchw'
Message-ID: <201706300950.K7MrkhVw%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Return-Path: <fengguang.wu@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58931
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fengguang.wu@intel.com
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


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   git://git.linux-mips.org/pub/scm/sjhill/linux-sjhill.git mips-for-linux-next
head:   152e63e374cdc0dc7a321d523dd2930de0acdabf
commit: 0b17c9670590148656645be57f62f279f0d3ad52 [46/72] MIPS: Use queued spinlocks (qspinlock)
config: mips-bigsur_defconfig (attached as .config)
compiler: mips64-linux-gnuabi64-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 0b17c9670590148656645be57f62f279f0d3ad52
        # save the attached .config to linux build tree
        make.cross ARCH=mips 

All errors (new ones prefixed by >>):

   kernel/locking/qspinlock.c: In function 'queued_spin_lock_slowpath':
>> kernel/locking/qspinlock.c:549:4: error: implicit declaration of function 'prefetchw' [-Werror=implicit-function-declaration]
       prefetchw(next);
       ^~~~~~~~~
   cc1: some warnings being treated as errors

vim +/prefetchw +549 kernel/locking/qspinlock.c

8d53fa190 Peter Zijlstra         2016-06-08  533  		 */
8d53fa190 Peter Zijlstra         2016-06-08  534  		smp_read_barrier_depends();
8d53fa190 Peter Zijlstra         2016-06-08  535  
a33fda35e Waiman Long            2015-04-24  536  		WRITE_ONCE(prev->next, node);
a33fda35e Waiman Long            2015-04-24  537  
cd0272fab Waiman Long            2015-11-09  538  		pv_wait_node(node, prev);
a33fda35e Waiman Long            2015-04-24  539  		arch_mcs_spin_lock_contended(&node->locked);
81b559866 Waiman Long            2015-11-09  540  
81b559866 Waiman Long            2015-11-09  541  		/*
81b559866 Waiman Long            2015-11-09  542  		 * While waiting for the MCS lock, the next pointer may have
81b559866 Waiman Long            2015-11-09  543  		 * been set by another lock waiter. We optimistically load
81b559866 Waiman Long            2015-11-09  544  		 * the next pointer & prefetch the cacheline for writing
81b559866 Waiman Long            2015-11-09  545  		 * to reduce latency in the upcoming MCS unlock operation.
81b559866 Waiman Long            2015-11-09  546  		 */
81b559866 Waiman Long            2015-11-09  547  		next = READ_ONCE(node->next);
81b559866 Waiman Long            2015-11-09  548  		if (next)
81b559866 Waiman Long            2015-11-09 @549  			prefetchw(next);
a33fda35e Waiman Long            2015-04-24  550  	}
a33fda35e Waiman Long            2015-04-24  551  
a33fda35e Waiman Long            2015-04-24  552  	/*
c1fb159db Peter Zijlstra (Intel  2015-04-24  553) 	 * we're at the head of the waitqueue, wait for the owner & pending to
c1fb159db Peter Zijlstra (Intel  2015-04-24  554) 	 * go away.
a33fda35e Waiman Long            2015-04-24  555  	 *
c1fb159db Peter Zijlstra (Intel  2015-04-24  556) 	 * *,x,y -> *,0,0
2c83e8e94 Waiman Long            2015-04-24  557  	 *

:::::: The code at line 549 was first introduced by commit
:::::: 81b5598665a24083dd889fbd8cb08b0d8de4b8ad locking/qspinlock: Prefetch the next node cacheline

:::::: TO: Waiman Long <Waiman.Long@hpe.com>
:::::: CC: Ingo Molnar <mingo@kernel.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--wRRV7LY7NUeQGEoC
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--wRRV7LY7NUeQGEoC--
